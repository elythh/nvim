require("bufferline").setup({
  highlights = (function()
    local groups = {
      "fill",
      "background",
      "tab",
      "tab_selected",
      "tab_separator",
      "tab_separator_selected",
      "tab_close",
      "close_button",
      "close_button_visible",
      "close_button_selected",
      "buffer_visible",
      "buffer_selected",
      "buffer",
      "numbers",
      "numbers_visible",
      "numbers_selected",
      "diagnostic",
      "diagnostic_visible",
      "diagnostic_selected",
      "hint",
      "hint_visible",
      "hint_selected",
      "hint_diagnostic",
      "hint_diagnostic_visible",
      "hint_diagnostic_selected",
      "info",
      "info_visible",
      "info_selected",
      "info_diagnostic",
      "info_diagnostic_visible",
      "info_diagnostic_selected",
      "warning",
      "warning_visible",
      "warning_selected",
      "warning_diagnostic",
      "warning_diagnostic_visible",
      "warning_diagnostic_selected",
      "error",
      "error_visible",
      "error_selected",
      "error_diagnostic",
      "error_diagnostic_visible",
      "error_diagnostic_selected",
      "modified",
      "modified_visible",
      "modified_selected",
      "duplicate_selected",
      "duplicate_visible",
      "duplicate",
      "separator",
      "separator_selected",
      "separator_visible",
      "indicator_visible",
      "indicator_selected",
      "pick_selected",
      "pick_visible",
      "pick",
      "offset_separator",
      "trunc_marker",
    }
    local hl = {}
    for _, g in ipairs(groups) do
      hl[g] = { bg = "NONE" }
    end
    return hl
  end)(),
  options = {
    indicator = { style = "none" },
    style = "none",
    mode = "buffers",
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = "bdelete! %d",
    buffer_close_icon = "x",
    modified_icon = "",
    close_icon = "X",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 15,
    truncate_names = false,
    tab_size = 15,
    diagnostics = false,
    show_buffer_icons = false,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = false,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    separator_style = "none",
    always_show_bufferline = true,
  },
})

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Cycle to next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Cycle to previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Cycle to next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Cycle to previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Delete buffers to the right" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Delete buffers to the left" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Delete other buffers" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle pin" })
vim.keymap.set("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })

require("lualine").setup({
  options = {
    global_status = true,
    disabled_filetypes = {
      statusline = { "ministarter" },
    },
    component_separators = {
      left = "",
      right = "",
    },
    section_separators = {
      left = "",
      right = "",
    },
    theme = {
      normal = { y = { bg = nil } },
      insert = { y = { bg = nil } },
      command = { y = { bg = nil } },
      visual = { y = { bg = nil } },
      replace = { y = { bg = nil } },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = { "branch", "diff" },
    lualine_x = { "diagnostics" },
    lualine_y = { "filetype", "progress", "location" },
    lualine_z = {},
  },
})

require("noice").setup({
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
  notify = {
    enabled = true,
    view = "notify",
  },
  messages = {
    enabled = true,
    view = "mini",
  },
  lsp = {
    message = { enabled = false },
    progress = {
      enabled = true,
      view = "mini",
    },
  },
  popupmenu = { enabled = true },
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
  },
})
