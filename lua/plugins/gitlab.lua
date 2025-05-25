return {
	"harrisoncramer/gitlab.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
		"nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
	},
	build = function()
		if vim.fn.executable("glab") == 1 then
			require("gitlab.server").build(true)
		end
	end, -- Builds the Go binary
	config = function()
		if vim.fn.executable("glab") == 1 then
			require("gitlab").setup()
		end
	end,
}
