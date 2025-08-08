return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
      disable_netrw = true,
      hijack_netrw = false,
      hijack_cursor = true,
      view = {
        centralize_selection = true,
        adaptive_size = false,
        side = "left",
        preserve_window_proportions = true,
        float = {
          enable = true,
          open_win_config = function()
            return {
              row = 0,
              width = 42,
              border = "rounded",
              relative = "editor",
              col = vim.o.columns,
              height = vim.o.lines,
            }
          end,
        },
      },
      actions = {
        open_file = {
          resize_window = false,
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = function()
      require("mappings").bufferline()
    end,
    opts = {
      options = {
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        show_tab_indicators = false,
        separator_style = { " ", " " },
        indicator = {
          style = "icon",
          icon = " ",
        },
        buffer_close_icon = "",
        modified_icon = "•",
        left_trunc_marker = "<-",
        right_trunc_marker = "->",
        color_icons = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = " Files",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    config = function()
      local clients_lsp = function()
        local bufnr = vim.api.nvim_get_current_buf()

        local clients = vim.lsp.get_clients { bufnr = bufnr }
        if next(clients) == nil then
          return ""
        end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return " " .. table.concat(c, "|")
      end

      local M = {
        options = {
          theme = "tokyonight",
          component_separators = "",
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "NvimTree", "snacks_dashboard" },
        },
        sections = {
          lualine_a = {
            { "mode", icon = "" },
          },
          lualine_b = {
            {
              "filetype",
              icon_only = true,
              padding = { left = 1, right = 0 },
            },
            "filename",
          },
          lualine_c = {
            {
              "branch",
              icon = "",
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              colored = false,
            },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = { error = " ", warn = " ", hint = " ", info = " " },
              update_in_insert = true,
            },
          },
          lualine_y = { clients_lsp },
          lualine_z = {
            { "location", icon = "" },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
      }

      require("lualine").setup(M)
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
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      icons = {
        mappings = false,
      },
      spec = {
        { "<leader>f", group = "[F]ind" },
        { "<leader>c", group = "[C]ode" },
        { "<leader>l", group = "[L]azy" },
        { "<leader>r", group = "[R]e..." },
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    init = function()
      require("notify").setup {
        background_colour = "#000000",
      }
    end,
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
  },
}
