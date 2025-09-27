return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    lazygit = {
      enabled = true,
    },
    indent = {
      indent = {
        enabled = false,
      },
      chunk = {
        enabled = true,
        only_current = true,
        char = {
          arrow = "─",
          corner_top = "╭",
          corner_bottom = "╰",
        },
        hl = "SnacksIndentScope",
      },
      notifier = {
        enabled = true,
        style = "minimal",
        timeout = 3000,
      },
    },
  },
}
