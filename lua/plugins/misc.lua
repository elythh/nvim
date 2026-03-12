local conf_path = vim.fn.stdpath "config" --[[@as string]]

return {
  { "nvim-lua/plenary.nvim", lazy = true },

  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "kiyoon/treesitter-indent-object.nvim",
    keys = {
      {
        "ai",
        function()
          require("treesitter_indent_object.textobj").select_indent_outer()
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer)",
      },
      {
        "aI",
        function()
          require("treesitter_indent_object.textobj").select_indent_outer(true, "V")
          require("treesitter_indent_object.refiner").include_surrounding_empty_lines()
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer, line-wise)",
      },
      {
        "ii",
        function()
          require("treesitter_indent_object.textobj").select_indent_inner()
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, partial range)",
      },
      {
        "iI",
        function()
          require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VimEnter",
    branch = "master",
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
      require("mappings").lsp()
      require("mappings").misc()
      require("mappings").mini()
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
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = function()
      local hl_cursor_line = vim.api.nvim_get_hl(0, { name = "CursorLine" })
      local hl_comment = vim.api.nvim_get_hl(0, { name = "Comment" })
      local hl_combined = vim.tbl_extend("force", hl_comment, { bg = hl_cursor_line.bg })
      vim.api.nvim_set_hl(0, "CursorLineBlame", hl_combined)
      return {
        message_template = " <author> • <date> • <summary>",
        date_format = "%r",
        virtual_text_column = 1,
        enabled = true,
        highlight_group = "CursorLineBlame",
        -- etc.
      }
    end,
  },
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      -- this will download prebuild binary or try to use existing rustup toolchain to build from source
      -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
      require("fff.download").download_or_build_binary()
    end,
    -- if you are using nixos
    -- build = "nix run .#release",
    opts = { -- (optional)
      debug = {
        enabled = true, -- we expect your collaboration at least during the beta
        show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
      },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    keys = {
      {
        "ff", -- try it if you didn't it is a banger keybinding for a picker
        function()
          require("fff").find_files()
        end,
        desc = "FFFind files",
      },
    },
  },
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    branch = "stable",
    opts = {
      confirm_simple = true,
      mappings = {
        ["q"] = "CloseView",
        ["l"] = "Select",
        ["<C-t>"] = "SelectTab",
        ["|"] = "SelectVSplit",
        ["-"] = "SelectSplit",
        ["h"] = "GotoParent",
        ["="] = "GotoCwd",
        ["."] = "GotoNode",
        ["#"] = "CollapseAll",
        ["<BS>"] = "CollapseNode",
      },
    },
  },
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle { name = "claude", focus = true }
        end,
        desc = "Sidekick Claude Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
  {
    "ramilito/kubectl.nvim",
    -- use a release tag to download pre-built binaries
    version = "2.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'make build',
    -- OR if you use nix, build from source with:
    -- build = 'nix run .#build-plugin',
    dependencies = "saghen/blink.download",
    config = function()
      require("kubectl").setup()
    end,
  },
  {
    "allaman/tf.nvim",
    opts = {},
    ft = "terraform",
  },
  {
    "aikhe/wrapped.nvim",
    dependencies = { "nvzone/volt" },
    cmd = { "WrappedNvim" },
    opts = {},
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
