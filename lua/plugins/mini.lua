return {
	{
		"echasnovski/mini.base16",
		event = "VeryLazy",
		lazy = true,
		version = false,
	},
	{
		"echasnovski/mini.starter",
		lazy = false,
		config = function()
			local mini_starter = require("mini.starter")

			mini_starter.setup({
				evaluate_single = true,
				header = "hello",
				footer = "",
				content_hooks = {
					mini_starter.gen_hook.aligning("center", "center"),
				},
				items = {
					mini_starter.sections.builtin_actions(),
					mini_starter.sections.recent_files(5, true, false),
					mini_starter.sections.recent_files(5, false, false),
				},
			})
		end,
		version = false,
	},
	{
		"echasnovski/mini.files",
		lazy = false,
		config = function()
			local mini_files = require("mini.files")

			mini_files.setup({
				mappings = {
					synchronize = "s",
				},
			})
		end,
		version = false,
	},
	{
		"echasnovski/mini.ai",
		events = { "UIEnter" },
		lazy = true,
		config = function()
			local mini_ai = require("mini.ai")

			mini_ai.setup({})
		end,
		version = false,
	},
	{
		"echasnovski/mini.pairs",
		events = { "UIEnter" },
		lazy = true,
		config = function()
			local mini_pairs = require("mini.pairs")

			mini_pairs.setup({})
		end,
		version = false,
	},
}
