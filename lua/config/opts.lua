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
o.clipboard = "unnamedplus"
o.scrolloff = 20

-- Indents settings
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true

-- UI
o.showcmd = false
o.number = true
o.relativenumber = true
o.showtabline = 1
o.signcolumn = "yes"
o.breakindent = true
vim.g.termguicolors = true
o.updatetime = 250
o.showmode = false
o.laststatus = 3
o.fillchars = { eob = " " }
vim.go.guicursor = "n-v-sm:block,i-t-ci-ve-c:ver25,r-cr-o:hor20"
-- Search
o.ignorecase = true
o.smartcase = true

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
