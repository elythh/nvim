return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        indicator = {
          style = "none",
        },
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
    },
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle to next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle to previous buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle to next buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle to previous buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete buffer" },
      { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
      { "<leader>`", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete buffers to the left" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete other buffers" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("lualine").setup {
        options = {
          global_status = true,
          disabled_filetypes = {
            statusline = {
              "ministarter",
            },
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
            normal = {
              y = { bg = nil },
            },
            insert = {
              y = { bg = nil },
            },
            command = {
              y = { bg = nil },
            },
            visual = {
              y = { bg = nil },
            },
            replace = {
              y = { bg = nil },
            },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filename" },
          lualine_c = {
            "branch",
            "diff",
          },
          lualine_x = { "diagnostics" },
          lualine_y = {
            "filetype",
            "progress",
            "location",
          },
          lualine_z = {},
        },
      }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        delay = 0,
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
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
        message = {
          enabled = false,
        },
        progress = {
          enabled = true,
          view = "mini",
        },
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
      },
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
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}
