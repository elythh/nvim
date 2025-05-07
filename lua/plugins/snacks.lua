return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {
			enabled = true,
			matcher = {
				frecency = true,
			},
			layouts = {
				default = {
					reverse = true,
					layout = {
						box = "horizontal",
						backdrop = true,
						width = 0.8,
						height = 0.9,
						border = "none",
						{
							box = "vertical",
							{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
						},
						{
							win = "preview",
							title = "{preview:Preview}",
							width = 0.45,
							border = "rounded",
							title_pos = "center",
						},
					},
				},
			},
		},
		lazygit = {
			enabled = true,
		},
		indent = {
			indent = {
				enabled = false,
			},
			chunk = {
				enabled = true,
				only_current = true,
				char = {
					arrow = "─",
					corner_top = "╭",
					corner_bottom = "╰",
				},
				hl = "SnacksIndentScope",
			},
			notifier = {
				enabled = true,
				style = "minimal",
				timeout = 3000,
			},
		},
	},
	keys = {
		-- Picker
		{
			"<leader>f'",
			function()
				Snacks.picker.marks()
			end,
			desc = "Find marks",
		},
		{
			"<leader>f/",
			function()
				Snacks.picker.lines()
			end,
			desc = "Fuzzy find in current buffer",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume find",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fo",
			function()
				Snacks.picker.recent()
			end,
			desc = "Find old files",
		},
		{
			"<leader>fq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Find quickfix",
		},
		{
			"<leader>ld",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"<leader>li",
			function()
				Snacks.picker.lsp_implementation()
			end,
			desc = "Goto Implementation",
		},
		{
			"<leader>lD",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "Find references",
		},
		{
			"<leader>lt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto Type Definition",
		},
		{
			"<leader>fS",
			function()
				Snacks.picker.spell_suggest()
			end,
			desc = "Find spelling suggestions",
		},
		{
			"<leader>fH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Find highlights",
		},
		{
			"<leader>gB",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Find git branches",
		},
		-- {
		-- 	"<leader>gs",
		-- 	function()
		-- 		Snacks.picker.git_status()
		-- 	end,
		-- 	desc = "Find git status",
		-- },
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>fa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Find autocmds",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Find buffer diagnostic",
		},
		{
			"<leader>fD",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Find workspace diagnostics",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Find help tags",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Find keymaps",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Find projects",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Find lsp document symbols",
		},
		{
			"<leader>fT",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Find theme",
		},
		{
			"<leader>fw",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>fO",
			function()
				Snacks.picker.smart()
			end,
			desc = "Find Smart (Frecency)",
		},
		{
			"<leader>f?",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Fuzzy find in open buffers",
		},
		-- Lazygit
		{
			"<leader>gg",
			function()
				Snacks.lazygit.open()
			end,
			desc = "Open Lazygit",
		},
		{
			"<leader>kt",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Open Loclist",
		},
	},
}
