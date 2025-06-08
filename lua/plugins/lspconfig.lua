return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspStart" },
		config = function()
			require("lspconfig").yamlls.setup({
				settings = {
					yaml = {
						format = { enable = true },
						validate = { enable = true },
					},
				},
			})

			local servers = {
				"lua_ls",
				"markdown_oxide",
				"nixd",
				"yamlls",
				"terraformls",
				"pylsp",
        "qmlls",
			}

			for _, server in pairs(servers) do
				vim.lsp.enable(server)
			end
			vim.lsp.inlay_hint.enable(true)

			vim.api.nvim_create_autocmd("LspAttach", {
				-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/init.lua
				group = vim.api.nvim_create_augroup("ElythLsp", {}),
				callback = function(_)
					local lsp = vim.lsp.buf
					vim.keymap.set("n", "gd", lsp.definition, { desc = "Goto Definition" })
					vim.keymap.set("n", "gr", lsp.references, { desc = "Goto References" })
					vim.keymap.set("n", "gD", lsp.declaration, { desc = "Goto Declaration" })
					vim.keymap.set("n", "gi", lsp.implementation, { desc = "Goto Implementation" })
					vim.keymap.set("n", "gT", lsp.type_definition, { desc = "Type Definition" })
					vim.keymap.set("n", "K", lsp.hover, { desc = "Hover" })
					vim.keymap.set("n", "<leader>cw", lsp.workspace_symbol, { desc = "Workspace Symbol" })
					vim.keymap.set("n", "<leader>ra", lsp.rename, { desc = "Rename" })
					vim.keymap.set("n", "<leader>ca", lsp.code_action, { desc = "Code Action" })
					vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

					local diag = vim.diagnostic
					vim.keymap.set("n", "[d", function()
						diag.jump({ count = 1, float = true })
					end, { desc = "Next Diagnostic" })
					vim.keymap.set("n", "]d", function()
						diag.jump({ count = -1, float = true })
					end, { desc = "Previous Diagnostic" })
				end,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				beacon = {
					enable = true,
				},
				ui = {
					border = "rounded",
					codeAction = "💡",
				},
				hover = {
					openCmd = "!floorp",
					openLink = "gx",
				},
				diagnostic = {
					borderFollow = true,
					diagnosticOnlyCurrent = false,
					showCodeAction = true,
				},
				symbolInWinbar = {
					enable = true,
				},
				codeAction = {
					extendGitSigns = false,
					showServerName = true,
					onlyInCursor = true,
					numShortcut = true,
					keys = {
						exec = "<CR>",
						quit = {
							"<Esc>",
							"q",
						},
					},
				},
				lightbulb = {
					enable = false,
					sign = false,
					virtualText = true,
				},
				implement = {
					enable = false,
				},
				rename = {
					autoSave = false,
					keys = {
						exec = "<CR>",
						quit = {
							"<C-k>",
							"<Esc>",
						},
						select = "x",
					},
				},
				outline = {
					autoClose = true,
					autoPreview = true,
					closeAfterJump = true,
					layout = "normal",
					winPosition = "right",
					keys = {
						jump = "e",
						quit = "q",
						toggleOrJump = "o",
					},
				},
				scrollPreview = {
					scrollDown = "<C-f>",
					scrollUp = "<C-b>",
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}
