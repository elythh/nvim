local m = vim.keymap.set

-- Turn off highlighting
m("n", "<Esc>", "<cmd>noh<CR>", { silent = true })

-- Window :3
m("n", "<C-h>", "<C-w>h")
m("n", "<C-l>", "<C-w>l")
m("n", "<C-j>", "<C-w>j")
m("n", "<C-k>", "<C-w>k")

-- Move up & down within wrapped line
m({ "n", "v" }, "k", [[v:count || mode(1)[0:1] == "no" ? "k" : "gk"]], { expr = true })
m({ "n", "v" }, "j", [[v:count || mode(1)[0:1] == "no" ? "j" : "gj"]], { expr = true })

-- Clipboard
m({ "n", "v" }, "<leader>y", [["+y]])
m("n", "<leader>Y", [["+Y]])

-- Greatest keybinds ever
m("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
m("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- QOL
m("n", "J", "mzJ`z")
m("v", "<", "<gv")
m("v", ">", ">gv")

-- Mini
m("n", "-", ":lua  MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>")

