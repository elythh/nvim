return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = true,
		event = "VeryLazy",
		config = function()
			local colors = require("themes." .. _G.theme)

			require("lualine").setup({
				options = {
					global_status = true,
					disabled_filetypes = {
						statusline = {
							"ministarter",
						},
					},
					component_separators = {
						left = "",
						right = "",
					},
					section_separators = {
						left = "",
						right = "",
					},
					theme = {
						normal = {
							a = {
								bg = colors.base00,
								fg = colors.base0D,
							},
							b = {
								bg = colors.base00,
								fg = colors.base05,
							},
							c = {
								bg = colors.base00,
								fg = colors.base05,
							},
							z = {
								bg = colors.base00,
								fg = colors.base05,
							},
							y = {
								bg = colors.base00,
								fg = colors.base05,
							},
						},
						insert = {
							a = {
								bg = colors.base00,
								fg = colors.base0E,
							},
							b = {
								bg = colors.base00,
								fg = colors.base05,
							},
							c = {
								bg = colors.base00,
								fg = colors.base05,
							},
							z = {
								bg = colors.base00,
								fg = colors.base05,
							},
							y = {
								bg = colors.base00,
								fg = colors.base05,
							},
						},
						command = {
							a = {
								bg = colors.base00,
								fg = colors.base08,
							},
							b = {
								bg = colors.base00,
								fg = colors.base05,
							},
							c = {
								bg = colors.base00,
								fg = colors.base05,
							},
							z = {
								bg = colors.base00,
								fg = colors.base05,
							},
							y = {
								bg = colors.base00,
								fg = colors.base05,
							},
						},
						visual = {
							a = {
								bg = colors.base00,
								fg = colors.base0B,
							},
							b = {
								bg = colors.base00,
								fg = colors.base05,
							},
							c = {
								bg = colors.base00,
								fg = colors.base05,
							},
							z = {
								bg = colors.base00,
								fg = colors.base05,
							},
							y = {
								bg = colors.base00,
								fg = colors.base05,
							},
						},
						replace = {
							a = {
								bg = colors.base00,
								fg = colors.base0A,
							},
							b = {
								bg = colors.base00,
								fg = colors.base05,
							},
							c = {
								bg = colors.base00,
								fg = colors.base05,
							},
							z = {
								bg = colors.base00,
								fg = colors.base05,
							},
							y = {
								bg = colors.base00,
								fg = colors.base05,
							},
						},
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename" },
					lualine_c = {
						"branch",
						"diff",
						{
							function()
								return ("%s"):format(require("schema-companion.context").get_buffer_schema().name)
							end,
							cond = function()
								return package.loaded["schema-companion"]
							end,
						},
					},
					lualine_x = { "diagnostics" },
					lualine_y = {
						"progress",
						"location",
					},
					lualine_z = { "filetype" },
				},
			})
		end,
	},
}
