local colors = require("prism.themer"):getColors()
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

lualine.setup({
  options = {
    component_separators = { left = " ", right = " " },
    theme = {
      normal = {
        a = { fg = colors.color4, bg = colors.bg },
        b = { fg = colors.color6, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
        x = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.color14, bg = colors.bg },
        z = { fg = colors.grey, bg = colors.bg },
      },
      insert = {
        a = { fg = colors.color2, bg = colors.bg },
        z = { fg = colors.grey, bg = colors.bg },
      },
      visual = {
        a = { fg = colors.color14, bg = colors.bg },
        z = { fg = colors.grey, bg = colors.bg },
      },
      terminal = {
        a = { fg = colors.color3, bg = colors.bg },
        z = { fg = colors.grey, bg = colors.bg },
      },
    },

    globalstatus = true,
    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
  },
  sections = {
    lualine_a = { { "mode", icon = "" } },
    lualine_b = { { "branch", icon = "" } },
    lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = "󰝶 ",
        },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      {
        "filename",
        symbols = { modified = "  ", readonly = "", unnamed = "" },
      },
    },
    lualine_x = {
      {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = { fg = colors.color2 },
      },
      { "diff" },
    },
    lualine_y = {
      {
        "progress",
      },
      {
        "location",
        color = { fg = colors.color6, bg = colors.bg },
      },
    },
    lualine_z = {
      function()
        return "  " .. os.date("%X") .. " 📎"
      end,
    },
  },
})
