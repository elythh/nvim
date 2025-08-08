local function map(mode, keys, action, desc, isRemap)
  desc = desc or " "
  remap = remap or false
  local opts = { noremap = true, silent = true, desc = desc, remap = isRemap }
  vim.keymap.set(mode, keys, action, opts)
end

local M = {}

M.general = function()
  map("n", "<Up>", "<Nop>")
  map("n", "<Left>", "<Nop>")
  map("n", "<Right>", "<Nop>")
  map("n", "<Down>", "<Nop>")

  map("i", "<C-b>", "<ESC>^i", "move beginning of line")
  map("i", "<C-e>", "<End>", "move end of line")
  map("i", "<C-h>", "<Left>", "move left")
  map("i", "<C-l>", "<Right>", "move right")
  map("i", "<C-j>", "<Down>", "move down")
  map("i", "<C-k>", "<Up>", "move up")

  map("n", "<C-h>", "<C-w>h", "switch window left")
  map("n", "<C-l>", "<C-w>l", "switch window right")
  map("n", "<C-j>", "<C-w>j", "switch window down")
  map("n", "<C-k>", "<C-w>k", "switch window up")

  map("n", "<Esc>", "<cmd>noh<CR>", "general clear highlights")

  map("n", "<leader>/", "gcc", "Toggle Comment", true)
  map("v", "<leader>/", "gc", "Toggle Comment", true)
end

M.misc = function()
  map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", "NvimTree Toggle")
  map("n", "<leader>re", "<cmd>NvimTreeResize 36<CR>", "NvimTree Resize")

  map("n", "<leader>lg", function()
    Snacks.lazygit.open()
  end, "[L]azy[G]it")
  map({ "n", "t" }, "<C-t>", function()
    Snacks.terminal.toggle()
  end, "Terminal")
end

M.bufferline = function()
  map("n", "<leader>b", "<cmd>enew<CR>", "New buffer")
  map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", "Go to next buffer")
  map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", "Go to prev buffer")
  map("n", "q", function()
    Snacks.bufdelete()
  end, "Close buffer")
end

M.lsp = function()
  map("n", "<leader>ct", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", "[C]ode [T]rouble diagnostics")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  map("n", "gd", vim.lsp.buf.declaration, "[g]oto [d]eclaration")
  map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame Symbol")

  map("n", "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
  end, "[F]or[m]at File")
end

return M
