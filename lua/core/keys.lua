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

-- general mapping

-- Telescope
nmap_leader('fc', ":lua require('themes.schemer').setup(require('telescope.themes').get_dropdown{})<cr>",
  "Change Colorschemes")
nmap_leader("ff", ":Telescope find_files<cr>", "Find Files")
nmap_leader("fg", ":Telescope oldfiles<cr>", "Recently Opened")
nmap_leader("fr", ":Telescope live_grep<cr>", "Find String")
nmap_leader("fR", ":Telescope resume<cr>", "Resume")

-- git
nmap_leader("gg", ":LazyGit<cr>", "Open LazyGit")

-- Grapple
nmap_leader("Ga", ":GrappleTag<cr>", "Add A Bookmark")
nmap_leader("Gt", ":GrappleToggle<cr>", "Toggle Bookmark")
nmap_leader("Gr", ":GrappleUntag<cr>", "Remove Bookmark")
nmap_leader("Gg", ":GrapplePopup tags<cr>", "Show All Bookmarks")

-- terminal
nmap_leader("tt", ":ToggleTerm<cr>", "Split Below")

-- misc
nmap_leader("ll", ":Lazy<cr>", "Open Lazy")
nmap_leader("lc", ":lua require('telescope') vim.lsp.buf.code_action()<cr>", "Show Code Actions")
nmap_leader("lm", ":Mason<cr>", "Open Mason")
nmap_leader("ls", ":SymbolsOutline<cr>", "Overview of file")
nmap_leader("lw", ":SessionSave<cr>", "Save this session")
