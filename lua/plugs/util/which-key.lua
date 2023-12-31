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
    r = { ":Telescope live_grep<cr>", "Find String" },
    R = { ":Telescope resume<cr>", "Resume" },
    t = { ":Telescope track views<cr>", "Tracked files" },
    u = { ":Telescope undo<cr>", "Undo fzf" },
    w = { ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "Change worktrees" },
    W = { ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Create worktrees" }
  },
  g = {
    name = "Git",
    d = {
      "<cmd>lua require('plugs.util.diff')()<CR>",
      "Diff With",
    },
    g = { ":LazyGit<cr>", "Open LazyGit" }
  },
  G = {
    name = "Grapple",
    a = { ":GrappleTag<cr>", "Add A Bookmark" },
    t = { ":GrappleToggle<cr>", "Toggle Bookmark" },
    r = { ":GrappleUntag<cr>", "Remove Bookmark" },
    g = { ":GrapplePopup tags<cr>", "Show All Bookmarks" }
  },
  l = {
    name = "Misc",
    l = { ":Lazy<cr>", "Open Lazy" },
    c = { ":lua require('telescope') vim.lsp.buf.code_action()<cr>", "Show Code Actions" },
    m = { ":Mason<cr>", "Open Mason" },
    s = { ":SymbolsOutline<cr>", "Overview of file" },
    t = { ":Trouble<cr>", "Open Trouble" },
    n = { ":Neogit<cr>", "Open Neogit" },
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
  t = {
    name = "Track",
    a = { ":TrackMark<cr>", "Track Mark" },
    A = { ":TrackMark<cr>", "Track Mark All" },
    u = { ":TrackUnmark<cr>", "Track Unmark" },

  },
}

local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
