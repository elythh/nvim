local function lsp_status()
	local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
	if #attached_clients == 0 then
		return ""
	end
	local names = {}
	for _, client in ipairs(attached_clients) do
		local name = client.name:gsub("language.server", "ls")
		table.insert(names, name)
	end
	-- Directly embed color using highlight group 'LspIcon'
	return "%#LspIcon# %#lualine_y_normal# " .. table.concat(names, ", ")
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = true,
		event = "VeryLazy",
		config = function()
			local colors = require("themes." .. _G.theme)

			-- Define a highlight group for the LSP icon
			vim.api.nvim_set_hl(0, "LspIcon", { fg = colors.base0C, bg = nil }) -- Change colors.base0C to your desired color

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
							a = { bg = colors.base00, fg = colors.base0D },
							b = { bg = colors.base00, fg = colors.base04 },
							c = { bg = colors.base00, fg = colors.base04 },
							x = { bg = colors.base00, fg = colors.base05 },
							z = { bg = colors.base00, fg = colors.base04 },
							y = { bg = colors.base00, fg = colors.base04 },
						},
						insert = {
							a = { bg = colors.base00, fg = colors.base0E },
							b = { bg = colors.base00, fg = colors.base04 },
							c = { bg = colors.base00, fg = colors.base04 },
							x = { bg = colors.base00, fg = colors.base05 },
							z = { bg = colors.base00, fg = colors.base04 },
							y = { bg = colors.base00, fg = colors.base04 },
						},
						command = {
							a = { bg = colors.base00, fg = colors.base08 },
							b = { bg = colors.base00, fg = colors.base04 },
							c = { bg = colors.base00, fg = colors.base04 },
							x = { bg = colors.base00, fg = colors.base05 },
							z = { bg = colors.base00, fg = colors.base04 },
							y = { bg = colors.base00, fg = colors.base04 },
						},
						visual = {
							a = { bg = colors.base00, fg = colors.base0B },
							b = { bg = colors.base00, fg = colors.base05 },
							c = { bg = colors.base00, fg = colors.base05 },
							x = { bg = colors.base00, fg = colors.base05 },
							z = { bg = colors.base00, fg = colors.base05 },
							y = { bg = colors.base00, fg = colors.base05 },
						},
						replace = {
							a = { bg = colors.base00, fg = colors.base0A },
							b = { bg = colors.base00, fg = colors.base05 },
							c = { bg = colors.base00, fg = colors.base05 },
							x = { bg = colors.base00, fg = colors.base05 },
							z = { bg = colors.base00, fg = colors.base05 },
							y = { bg = colors.base00, fg = colors.base05 },
						},
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename" },
					lualine_c = {
						"branch",
						"diff",
					},
					lualine_x = { "diagnostics"},
					lualine_y = {
            lsp_status,
						"filetype",
						"progress",
						"location",
					},
					lualine_z = {},
				},
			})
		end,
	},
}
