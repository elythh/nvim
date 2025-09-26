local conf_path = vim.fn.stdpath "config" --[[@as string]]

return {
  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VimEnter",
    build = require("nixCatsUtils").lazyAdd ":TSUpdate",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = require("nixCatsUtils").lazyAdd {
          "lua",
          "vim",
          "vimdoc",
          "html",
          "css",
          "typescript",
          "javascript",
          "svelte",
          "rust",
          "astro",
          "nix",
        },
        auto_install = not require("nixCatsUtils").isNixCats,
        highlight = {
          enable = true,
          use_languagetree = true,
        },
        indent = { enable = true },
      }
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
  },
  {
    "allaman/kustomize.nvim",
    requires = "nvim-lua/plenary.nvim",
    ft = "yaml",
    opts = {
      build = {
        additional_args = { "--enable-helm", "--load-restrictor=LoadRestrictionsNone" },
      },
    },
  },

  {
    "options",
    event = "VeryLazy",
    dir = conf_path,
    config = function()
      require("plugins.scrollEOF").setup {}
      require("opts").final()
      require("mappings").general()
      require("mappings").misc()
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup {
        callbacks = {
          ["github.com"] = require("gitlinker.hosts").get_github_type_url,
          ["gitlab.dnm.radiofrance.fr"] = require("gitlinker.hosts").get_github_type_url,
        },
      }
    end,
  },
}
