return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "disrupted/blink-cmp-conventional-commits",
      "mikavilpas/blink-ripgrep.nvim",
      "moyiz/blink-emoji.nvim",
      "fang2hou/blink-copilot",
      "Kaiser-Yang/blink-cmp-git",
    },
    -- build = 'cargo build --release',
    version = "v1.7.0",
    event = { "BufReadPre", "InsertEnter", "CmdlineEnter" },
    lazy = true,
    ---@module 'blink.cmp'
    opts = {
      keymap = {
        preset = "none",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CS-j>"] = { "scroll_documentation_down", "fallback" },
        ["<CS-k>"] = { "scroll_documentation_up", "fallback" },
        ["<C-space>"] = {
          "show",
          "show_documentation",
          "hide_documentation",
        },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },
      },

      appearance = {
        nerd_font_variant = "normal",
      },

      sources = {
        default = { "conventional_commits", "lsp", "buffer", "path", "emoji", "git", "ripgrep" },
        providers = {
          ripgrep = {
            name = "Ripgrep",
            module = "blink-ripgrep",
            score_offset = 1,
          },
          emoji = {
            name = "Emoji",
            module = "blink-emoji",
            score_offset = 1,
          },
          conventional_commits = {
            name = "Conventional Commits",
            module = "blink-cmp-conventional-commits",
            enabled = function()
              return vim.bo.filetype == "gitcommit"
            end,
            ---@module 'blink-cmp-conventional-commits'
            ---@type blink-cmp-conventional-commits.Options
            opts = {}, -- none so far
          },
          lsp = { score_offset = 1 },
          git = {
            name = "Git",
            module = "blink-cmp-git",
            enabled = true,
            score_offset = 100,
            should_show_items = function()
              return vim.o.filetype == "gitcommit" or vim.o.filetype == "markdown"
            end,
            opts = {
              git_centers = {
                github = {
                  issue = {
                    on_error = function(_, _)
                      return true
                    end,
                  },
                },
              },
            },
          },
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          window = {
            scrollbar = false,
            border = "single",
          },
        },
        ghost_text = { enabled = true },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
  },
}
