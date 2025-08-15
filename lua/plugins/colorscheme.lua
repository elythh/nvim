return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup {
        transparent = true,
        on_highlights = function(hl, c)
          hl.TabLineFill = {
            bg = c.none,
          }
          hl.BlinkCmpMenu = {
            bg = c.bg_dark,
          }
          hl.BlinkCmpMenuSelection = {
            bg = c.bg_highlight,
          }
          hl.BlinkCmpDoc = {
            bg = c.bg_dark,
          }
          hl.BlinkCmpMenuBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.BlinkCmpdocBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end,
        on_colors = function(colors)
          colors.bg_statusline = colors.none
        end,
        styles = {
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
      }

      vim.cmd.colorscheme "tokyonight-moon"
    end,
  },
  -- {
  --   "catppuccin/nvim",
  --   event = "VimEnter",
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup {
  --       flavour = "mocha",
  --       transparent_background = true,
  --       integrations = {
  --         blink_cmp = true,
  --         noice = true,
  --         nvimtree = true,
  --         native_lsp = {
  --           enabled = true,
  --           virtual_text = {
  --             errors = { "italic" },
  --             hints = { "italic" },
  --             warnings = { "italic" },
  --             information = { "italic" },
  --           },
  --           underlines = {
  --             errors = { "undercurl" },
  --             hints = { "undercurl" },
  --             warnings = { "undercurl" },
  --             information = { "undercurl" },
  --           },
  --         },
  --         snacks = {
  --           enabled = true,
  --           indent_scope_color = "blue",
  --         },
  --       },
  --     }
  --
  --     vim.cmd.colorscheme "catppuccin"
  --   end,
  -- },
}
