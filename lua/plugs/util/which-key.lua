local wk = require("which-key")
wk.setup {
}

local mappings = {
  q = {
    name = 'File',
    q = { ":q<cr>", "Quit" },
    w = { ":wq<cr>", "Save & Quit" },
    s = { ":w<cr>", "Save" },
    f = { ":lua vim.lsp.buf.format()<CR>", "Format file" },
    x = { ":bdelete<cr>", "Close" },
  },
  f = {
    name = 'Telescope',
    c = { ":PrismTelescope<cr>", "Kolorschemes" },
    f = { ":Telescope find_files<cr>", "Find Files" },
    g = { ":Telescope oldfiles<cr>", "Recently Opened" },
    G = { ":Telescope gitmoji<cr>", "Gitmoji" },
    r = { ":Telescope live_grep<cr>", "Find String" },
    R = { ":Telescope resume<cr>", "Resume" },
  },
  g = {
    name = "Git",
    d = {
      "<cmd>lua require('plugs.util.diff')()<CR>",
      "Diff With",
    },
    g = { ":LazyGit<cr>", "Open LazyGit" }
  },
  l = {
    name = "Misc",
    l = { ":Lazy<cr>", "Open Lazy" },
    c = { ":lua require('telescope') vim.lsp.buf.code_action()<cr>", "Show Code Actions" },
    m = { ":Mason<cr>", "Open Mason" },
  },
}

local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
