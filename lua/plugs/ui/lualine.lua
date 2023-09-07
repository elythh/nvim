local themes = require("themes")
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- Require theme color you're using
local colors = themes.getCurrentTheme()

-- local hide_in_width = function()
--     return vim.fn.winwidth(0) > 80
-- end

local diagnostics = {
  "diagnostics",
  symbols = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
  },
  colored = true,
  diagnostics_color = {
    color_error = { fg = colors.color1 },
    color_warn = { fg = colors.color3 },
    color_info = { fg = colors.color11 },
    color_hint = { fg = colors.color4 }
  },
  always_visible = false,
  update_in_insert = true,
}

local branch = {
  "branch",
  icon = "",
  color = { fg = colors.foreground },
  padding = { left = 2, right = 2 },
}

local diff = {
  "diff",
  colored = true,
  color = {
    added    = 'DiffAdd',
    modified = 'DiffChange',
    removed  = 'DiffDelete',
  },
  symbols = { added = " ", modified = " ", removed = " " },
  padding = { left = -1, right = 1 },
}

local location = {
  "location",
  padding = 1,
}

local modes = {
  function()
    vim.cmd "function! ToggleTheme(a,b,c,d) \n lua require('themes.schemer').setup(require('telescope.themes').get_dropdown{}) \n endfunction"
    local animated = {
      "%@ToggleTheme@" .. "  ",
      "%@ToggleTheme@" .. "  ",
      "%@ToggleTheme@" .. " 󱠡 ",
    }
    return animated[os.date("%S") % #animated + 1]
  end,
  separator = { left = "█", right = "█" },
}

local indent = function()
  return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local lsp_progess = function()
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.attached_buffers[vim.api.nvim_get_current_buf()] then
      return " " .. client.name .. " "
    end
  end
end

lualine.setup({
  options = {
    disabled_filetypes = { 'alpha', 'NVimTree', "lazy" },
    globalstatus = true,
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      modes,
    },
    lualine_b = {
      {
        "filetype",
        icon_only = true,
        colored = true,
        padding = { left = 2 },
        color = { bg = colors.cursor },
      },
      {
        "filename",
        padding = 1,
        separator = { left = "█", right = "█" },
        color = { bg = colors.foreground, fg = colors.darker, gui = "bold" },
        file_status = true,
        newfile_status = true,
        path = 5,
        symbols = {
          modified = "●",
          readonly = "",
          unnamed = "",
          newfile = "",
        },
      },
    },
    lualine_c = {
      branch,
      diff,
      {
        function()
          return " "
        end,
        separator = { left = "█", right = "█" },
        color = { fg = colors.foreground },
      }
    },
    lualine_x = {
      {
        function()
          return " "
        end,
        separator = { left = "█", right = "█" },
        color = 'LualineA',
      },
      diagnostics,
      {
        lsp_progess,
      },
      {
        function()
          return " "
        end,
        separator = { left = "█", right = "█" },
        color = 'LualineB',
      },
      indent,
      {
        function()
          return ""
        end,
        separator = { left = "█", right = "█" },
        color = 'LualineA',
      },
      "progress",
      {
        function()
          return " "
        end,
        separator = { left = "█", right = "█" },
        color = 'LualineB',
      },
      location,
      {
        function()
          local current_line = vim.fn.line(".")
          local total_lines = vim.fn.line("$")
          local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
          local progress_percent = current_line / total_lines
          local index = math.ceil(progress_percent * #chars)
          return chars[index]
        end,
        color = { fg = colors.color4 },
      }
    },
    lualine_y = {},
    lualine_z = {},
  },
})
