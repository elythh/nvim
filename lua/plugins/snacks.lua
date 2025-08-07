return {
  {
    "folke/snacks.nvim",
    event = "VimEnter",
    opts = {
      indent = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      notify = { enabled = true },
      scope = { enabled = true },
      lazygit = { enabled = true },
      statuscolumn = { enabled = true }, -- we set this in options.lua
      words = { enabled = true },
      scroll = {
        enabled = true,
      },
      terminal = {
        enabled = true,
        win = {
          style = "float",
          border = "rounded",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
        },
      },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "w", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
            },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = true },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
██╗ ██████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗
██║██╔════╝╚██╗ ██╔╝██║   ██║██║████╗ ████║
██║██║      ╚████╔╝ ██║   ██║██║██╔████╔██║
██║██║       ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
██║╚██████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝ ╚═════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
