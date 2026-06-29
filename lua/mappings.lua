local function map(mode, keys, action, desc, isRemap)
  local opts = { silent = true, desc = desc or " " }
  if isRemap then
    opts.remap = true
  else
    opts.noremap = true
  end
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

  map("n", "<Esc>", "<cmd>noh<CR>", "general clear highlights")

  map("n", "<leader>/", "gcc", "Toggle Comment", true)
  map("v", "<leader>/", "gc", "Toggle Comment", true)

  map("n", "[p", '<Cmd>exe "put! " . v:register<CR>', "Paste Above")
  map("n", "]p", '<Cmd>exe "put "  . v:register<CR>', "Paste Below")
end

M.misc = function()
  map("n", "<leader>gg", function()
    Snacks.lazygit.open()
  end, "LazyGit")
  map({ "n", "t" }, "<C-t>", function()
    Snacks.terminal.toggle()
  end, "Terminal")
  map("n", "-", "<cmd>Fyler<CR>", "Open Files")
end

M.lsp = function()
  map("n", "<leader>ct", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", "Code Trouble diagnostics")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")

  map("n", "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
  end, "Format File")
end

local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'
M.mini = function()
  map("n", "<leader>go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", "Toggle Diff overlay")

  map("n", "<leader>sd", '<Cmd>lua MiniSessions.select("delete")<CR>', "Delete Session")
  map("n", "<leader>sn", "<Cmd>lua " .. session_new .. "<CR>", "New Session")
  map("n", "<leader>sr", '<Cmd>lua MiniSessions.select("read")<CR>', "Read Session")
  map("n", "<leader>sw", "<Cmd>lua MiniSessions.write()<CR>", "Write current Session")
end

return M
