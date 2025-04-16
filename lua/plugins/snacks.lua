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
			win = {
				input = {
					{
						["<c-t>"] = {
							"trouble_open",
							mode = { "n", "i" },
						},
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
	},
}
