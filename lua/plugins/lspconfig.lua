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
						format = {
							enable = true,
						},
						validate = { enable = true },
						schemaStore = {
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = {
							kubernetes = "*.yaml",
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
							["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
							["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
							["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
							["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
							["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
							["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
							["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
						},
					},
				},
			})

			local servers = {
				"lua_ls",
				"markdown_oxide",
				"nixd",
				"yamlls",
				"terraformls",
			}

			for _, server in pairs(servers) do
				vim.lsp.enable(server)
			end

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
}
