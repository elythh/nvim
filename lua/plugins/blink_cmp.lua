return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"nvim-lua/plenary.nvim",

			"rafamadriz/friendly-snippets",
			"mikavilpas/blink-ripgrep.nvim",
			"moyiz/blink-emoji.nvim",
			"fang2hou/blink-copilot",
			"ribru17/blink-cmp-spell",
			"Kaiser-Yang/blink-cmp-dictionary",
			"Kaiser-Yang/blink-cmp-git",
			"huijiro/blink-cmp-supermaven",
		},
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		lazy = true,
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},

			appearance = {
				nerd_font_variant = "normal",
			},

			completion = {
				documentation = {
					auto_show = false,
					window = {
						scrollbar = false,
					},
				},
				menu = {
					border = "none",
					scrollbar = false,
					draw = {
						gap = 1,
						treesitter = { "lsp" },
						padding = { 0, 1 }, -- padding only on right side
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
							{ "source_name" },
						},
					},
				},
			},

			sources = {
				default = {
					"buffer",
					"lsp",
					"path",
          "supermaven",
					"snippets",
					"copilot",
					"dictionary",
					"emoji",
					"git",
					"spell",
					"ripgrep",
				},
				providers = {
					ripgrep = {
						name = "Ripgrep",
						module = "blink-ripgrep",
						score_offset = 1,
					},
					dictionary = {
						name = "Dict",
						module = "blink-cmp-dictionary",
						min_keyword_length = 3,
					},
					emoji = {
						name = "Emoji",
						module = "blink-emoji",
						score_offset = 1,
					},
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						async = true,
						score_offset = 100,
					},
					lsp = { score_offset = 4 },
					spell = {
						name = "Spell",
						module = "blink-cmp-spell",
						score_offset = 1,
					},
					supermaven = {
						name = "supermaven",
						module = "blink-cmp-supermaven",
						score_offset = 100,
						async = true,
					},
					git = {
						name = "Git",
						module = "blink-cmp-git",
						enabled = true,
						score_offset = 100,
						should_show_items = function()
							return vim.o.filetype == "gitcommit" or vim.o.filetype == "markdown"
						end,
						opts = {
							git_centers = {
								github = {
									issue = {
										on_error = function(_, _)
											return true
										end,
									},
								},
							},
						},
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
