return {
	"ruifm/gitlinker.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require("gitlinker").setup({
			callbacks = {
				["github.com"] = require"gitlinker.hosts".get_github_type_url,
				["gitlab.dnm.radiofrance.fr"] = require"gitlinker.hosts".get_github_type_url,
			},
		})
	end,
}
