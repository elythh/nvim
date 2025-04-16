vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

_G.theme = "houseki"

require("config.opts")
require("config.keybinds")
require("config.lazy")
require("config.ui")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	group = vim.api.nvim_create_augroup("Format", {}),
	callback = function(_)
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})
