vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

_G.theme = "everblush"

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

vim.api.nvim_create_autocmd("User", {
	pattern = "DiagnosticChanged",
	callback = function()
		vim.diagnostic.setloclist({ open = true })
	end,
})

-- Center cursor when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	callback = function()
		vim.cmd("norm zz")
	end,
})

-- Open help in a vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("wincmd L")
	end,
})

-- Close Snacks prompt in insert mode by clicking escape
vim.api.nvim_create_autocmd("FileType", {
	pattern = "snacks_picker_input",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "i", "<ESC>", "<ESC>:close!<CR>", { noremap = true, silent = true })
	end,
})

-- Enable spellcheck for some filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "tex", "latex", "markdown" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en,fr"
	end,
})

-- Highlight yank text
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})

-- Enter git buffer in insert mode
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "gitrebase" },
	callback = function()
		vim.cmd("startinsert | 1")
	end,
})

-- q to quit on help
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = 0 })
	end,
})

-- disable new line autocomment
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Prefer LSP folding if client supports it. Allows to fold comments and more
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
