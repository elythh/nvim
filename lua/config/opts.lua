local o = vim.opt
-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better UX
o.autowriteall = true
o.splitright = true
o.splitbelow = true
o.swapfile = false
o.undofile = true
o.backup = false
o.writebackup = false
o.clipboard = "unnamedplus"
o.scrolloff = 10

o.cursorline = true
o.cursorlineopt = "screenline"
o.cursorcolumn = true

-- Indents settings
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.copyindent = true
o.breakindent = true

-- UI
o.showcmd = false
-- Relative line number insert mode
o.number = true
vim.api.nvim_create_autocmd(
	{ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
	{ pattern = "*", command = "if &nu && mode() != 'i' | set rnu | endif" }
)
vim.api.nvim_create_autocmd(
	{ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "if &nu | set nornu | endif" }
)
-- o.relativenumber = true
o.showtabline = 1
o.signcolumn = "yes"
o.breakindent = true
vim.g.termguicolors = true
o.updatetime = 500
o.showmode = false
o.laststatus = 3
o.fillchars = { eob = " " }
vim.go.guicursor = "n-v-sm:block,i-t-ci-ve-c:ver25,r-cr-o:hor20"
-- Search
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

vim.diagnostic.config({
	virtual_text = true,
	float = { border = "rounded" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

-- https://www.reddit.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
-- Nice and simple folding:
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
o.foldcolumn = "0"
o.fillchars:append({ fold = " " })
