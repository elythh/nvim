return {
	{
		"echasnovski/mini.base16",
		event = "VeryLazy",
		lazy = true,
		version = false,
	},
	{
		"echasnovski/mini.hipatterns",
		lazy = false,
		version = false,
		config = function()
			local mini_hipatterns = require("mini.hipatterns")

			mini_hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = mini_hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
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
				windows = {
					preview = true,
					width_preview = 60,
				},
			})
		end,
		version = false,
	},
	{
		"echasnovski/mini.ai",
		lazy = false,
		config = function()
			local mini_ai = require("mini.ai")

			mini_ai.setup({ n_lines = 500 })
		end,
		version = false,
	},
	{
		"echasnovski/mini.pairs",
		events = { "BufEnter" },
		lazy = true,
		config = function()
			local mini_pairs = require("mini.pairs")

			mini_pairs.setup({})
		end,
		version = false,
	},
  {
		"echasnovski/mini.clue",
		events = { "BufEnter" },
		lazy = true,
    event = "VeryLazy",
		config = function()
			local mini_clue = require("mini.clue")

			mini_clue.setup({
				window = {
					delay = 500,
					config = {
						border = "none",
						width = math.floor(0.318 * vim.o.columns),
						row = "auto",
						col = "auto",
						anchor = "NE",
					},
				},
				triggers = {
					{ mode = "n", keys = "<leader>" },
					{ mode = "x", keys = "<leader>" },
					{ mode = "i", keys = "<C-x>" },
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "n", keys = "]" },
					{ mode = "n", keys = "[" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },
					{ mode = "n", keys = "\"" },
					{ mode = "x", keys = "\"" },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },
					{ mode = "n", keys = "<C-w>" },
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},
				clues = {
					require('mini.clue').gen_clues.builtin_completion(),
					require('mini.clue').gen_clues.g(),
					require('mini.clue').gen_clues.marks(),
					require('mini.clue').gen_clues.registers(),
					require('mini.clue').gen_clues.windows(),
					require('mini.clue').gen_clues.z(),
				},
			})
		end,
		version = false,
  },
}
