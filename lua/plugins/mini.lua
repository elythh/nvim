return {
	-- {
	-- 	"echasnovski/mini.base16",
	-- 	event = "VeryLazy",
	-- 	lazy = true,
	-- 	version = false,
	-- },
	-- { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
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
			local map_split = function(buf_id, lhs, direction)
				local rhs = function()
					-- Make new window and set it as target
					local cur_target = MiniFiles.get_explorer_state().target_window
					local new_target = vim.api.nvim_win_call(cur_target, function()
						vim.cmd(direction .. " split")
						return vim.api.nvim_get_current_win()
					end)

					MiniFiles.set_target_window(new_target)

					-- This intentionally doesn't act on file under cursor in favor of
					-- explicit "go in" action (`l` / `L`). To immediately open file,
					-- add appropriate `MiniFiles.go_in()` call instead of this comment.
				end

				-- Adding `desc` will result into `show_help` entries
				local desc = "Split " .. direction
				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					-- Tweak keys to your liking
					map_split(buf_id, "<C-s>", "belowright horizontal")
					map_split(buf_id, "<C-v>", "belowright vertical")
					map_split(buf_id, "<C-t>", "tab")
				end,
			})

			local set_cwd = function()
				local path = (MiniFiles.get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				vim.fn.chdir(vim.fs.dirname(path))
			end

			-- Yank in register full path of entry under cursor
			local yank_path = function()
				local path = (MiniFiles.get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				vim.fn.setreg(vim.v.register, path)
			end

			-- Open path with system default handler (useful for non-text files)
			local ui_open = function()
				vim.ui.open(MiniFiles.get_fs_entry().path)
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local b = args.data.buf_id
					vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
					vim.keymap.set("n", "gX", ui_open, { buffer = b, desc = "OS open" })
					vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
				end,
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
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },
					{ mode = "n", keys = "<C-w>" },
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},
				clues = {
					require("mini.clue").gen_clues.builtin_completion(),
					require("mini.clue").gen_clues.g(),
					require("mini.clue").gen_clues.marks(),
					require("mini.clue").gen_clues.registers(),
					require("mini.clue").gen_clues.windows(),
					require("mini.clue").gen_clues.z(),
				},
			})
		end,
		version = false,
	},
}
