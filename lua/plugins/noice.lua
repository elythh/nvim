return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		notify = {
			enabled = true,
			view = "notify",
		},
		messages = {
			enabled = true,
			view = "mini",
		},
		lsp = {
			message = {
				enabled = false,
			},
			progress = {
				enabled = true,
				view = "mini",
			},
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
