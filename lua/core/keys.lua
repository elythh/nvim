vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end
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

map('n', 'zR', '<CMD>lua require("ufo").openAllFolds<CR>', { noremap = true, silent = true })
map('n', 'zM', '<CMD>lua require("ufo").closeAllFolds<CR>', { noremap = true, silent = true })

-- Yank buffer path
map("n", "cp", ':let @+ = expand("%")<CR>', { noremap = true, silent = true })
