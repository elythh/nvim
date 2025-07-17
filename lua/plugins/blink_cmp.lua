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
		},
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		lazy = true,
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "none",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<CS-j>"] = { "scroll_documentation_down", "fallback" },
				["<CS-k>"] = { "scroll_documentation_up", "fallback" },
				["<C-space>"] = {
					"show",
					"show_documentation",
					"hide_documentation",
				},
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },
			},

			appearance = {
				nerd_font_variant = "normal",
			},

			sources = {
				default = { "lsp", "buffer", "path", "dictionary", "emoji", "git", "spell", "ripgrep" },
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
			completion = {
				documentation = {
					auto_show = true,
					window = {
						scrollbar = false,
						border = "single",
					},
				},
				ghost_text = { enabled = true },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
