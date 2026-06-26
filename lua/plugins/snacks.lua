require("snacks").setup({
  lazygit = { enabled = true },
  statuscolumn = { enabled = true },
  indent = {
    indent = { enabled = false },
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
})
