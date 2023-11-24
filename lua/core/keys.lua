vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

-- Copy whole file content to clipboard with C-c
map("n", "<C-c>", "<CMD>%y+<CR>", { noremap = true, silent = false })
-- Save file with C-s
map("i", "<C-s>", "<CMD>w<CR><ESC>", { noremap = true, silent = false })
map("n", "<C-s>", "<CMD>w<CR><ESC>", { noremap = true, silent = false })
-- close current buffer
map("n", "<C-p>", "<CMD>bd<CR>", { noremap = true, silent = false })
-- Moving Between Buffers
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = false })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = false })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = false })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = false })

map('n', '<C-b>', '<CMD>NvimTreeToggle<CR>', { noremap = true, silent = true })
map('n', '<C-f>', '<CMD>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
map('n', '<C-t>', '<CMD>ToggleTerm<CR>', { noremap = true, silent = true })

-- Yank buffer path
map("n", "cp", ':let @+ = expand("%")<CR>', { noremap = true, silent = true })

-- greatest remap ever
map("v", "p", [["_dP]], { noremap = true, silent = true })

map("n", "-", "<CMD>Oil<CR>", { noremap = true, silent = true })
