return {
  {
    "cuddlefish.nvim",
    lazy = false,
    priority = 1200,
    after = function()
      require("cuddlefish").setup({
        theme = {
          accent = "pink",
        },
        editor = {
          transparent_background = false,
        },
        style = {
          tabline = { "reverse" },
          search = { "italic", "reverse" },
          incsearch = { "italic", "reverse" },
          types = { "italic" },
          keyword = { "italic" },
          comment = { "italic" },
        },
        overrides = function(colors)
          return {}
        end,
      })

      vim.cmd.colorscheme("cuddlefish")
    end,
  },

  {
    "catppuccin",
    lazy = false,
    priority = 1200,
    after = function()
      require("catppuccin").setup({
        flavour = "auto",
        background = {
          light = "latte",
          dark = "mocha",
        },
        term_colors = true,
        transparent_background = false,
        -- color_overrides = {
        --   mocha = {
        --     base = "#000000",
        --     mantle = "#000000",
        --     crust = "#000000",
        --   },
        -- },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        integrations = {
          alpha = true,
          treesitter = true,
          treesitter_context = false,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          telescope = {
            enabled = true,
          },
          cmp = false,
          blink_cmp = true,
          lsp_trouble = true,
          nvimtree = true,
          which_key = false,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          navic = {
            enabled = true,
            custom_bg = "NONE",
          },
          gitsigns = true,
          markdown = true,
          render_markdown = false,
          harpoon = true,
          symbols_outline = true,
          ts_rainbow = true,
          notify = true,
        },
      })
    end,
  },
}
