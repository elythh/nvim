return {
	{ "b0o/schemastore.nvim" },
	{
		"cwrau/yaml-schema-detect.nvim",
		config = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/which-key.nvim",
		},
		ft = { "yaml" },
	},
}
