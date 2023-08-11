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
    c = { ":lua require('themes.schemer').setup(require('telescope.themes').get_dropdown{})<cr>", "Change Colorschemes" },
    f = { ":Telescope find_files<cr>", "Find Files" },
    g = { ":Telescope oldfiles<cr>", "Recently Opened" },
    p = { ":Telescope project<cr>", "Find Project" },
    r = { ":Telescope live_grep<cr>", "Find String" },
    R = { ":Telescope resume<cr>", "Resume" },
    s = { ":Telescope persisted<cr>", "Sessions" }
  },
  g = {
    name = "Git",
    g = { ":LazyGit<cr>", "Open LazyGit" }
  },
  G = {
    name = "Grapple",
    a = { ":GrappleTag<cr>", "Add A Bookmark" },
    t = { ":GrappleToggle<cr>", "Toggle Bookmark" },
    r = { ":GrappleUntag<cr>", "Remove Bookmark" },
    g = { ":GrapplePopup tags<cr>", "Show All Bookmarks" }
  },
  t = {
    name = "Terminal",
    t = { ":ToggleTerm<cr>", "Split Below" },
  },
  l = {
    name = "Misc",
    l = { ":Lazy<cr>", "Open Lazy" },
    c = { ":lua require('telescope') vim.lsp.buf.code_action()<cr>", "Show Code Actions" },
    m = { ":Mason<cr>", "Open Mason" },
    s = { ":SymbolsOutline<cr>", "Overview of file" },
    w = { ":SessionSave<cr>", "Save this session" }
  },
  h = {
    name = "Hop",
    c = { ":HopChar1<cr>", "Single Character" },
    C = { ":HopChar2<cr>", "Double Characters" },
    a = { ":HopAnywhere<cr>", "Anywhere" },
    l = { ":HopLine<cr>", "Line" },
    L = { ":HopLineStart<cr>", "Line Start" },
    v = { ":HopVertical<cr>", "Vertically" },
    w = { ":HopWord<cr>", "Word" },
  },
  s = {
    name = "Spectre",
    S = { ":lua require('spectre').toggle()<CR>", "Toggle Spectre" },
    w = { ":lua require('spectre').open_visual({select_word=true})<CR>", "Search current word" },
    p = { ":lua require('spectre').open_file_search({select_word=true})<CR>", "Search on current file" },
  },
}

local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
