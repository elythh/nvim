require("plugs.strap")
local lazy = require("lazy")
lazy.setup({
  -- Highlight code
  {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    lazy = true,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function() require('plugs.ts.treesitter') end
  },
  {
    'windwp/nvim-ts-autotag',
    event = "InsertEnter",
    lazy = true
  },
  -- Highlight Hex colors in code
  {
    'NvChad/nvim-colorizer.lua',
    event = 'CursorHold',
    config = function() require('plugs.ui.colorizer') end,
    lazy = true
  },
  -- Icons for tree
  {
    "nvim-tree/nvim-web-devicons",
    event = 'CursorHold',
    config = function() require('plugs.ui.devicons') end,
    lazy = true,
  },
  -- Tree
  {
    'kyazdani42/nvim-tree.lua',
    lazy = true,
    cmd = "NvimTreeToggle",
    config = function() require('plugs.util.nvim-tree') end
  },
  -- Quickly define and find binds
  {
    "folke/which-key.nvim",
    keys = { "<leader>", ' ', "'", "`" },
    lazy = true,
    enabled = true,
    config = function() require('plugs.util.which-key') end
  },
  -- I dont even know but many plugins require it
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    lazy = true,
    dependencies = { 'plenary.nvim' },
    config = function() require('plugs.util.telescope') end
  },
  -- Toggle terminal windows
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    config = function() require('plugs.util.toggleterm') end,
    cmd = "ToggleTerm",
  },
  -- Adds indentation guides to all lines (including empty lines).
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    config = function() require('plugs.ui.indentlines') end,
    event = 'CursorHold',
  },
  -- Quickly comment codeinit
  {
    "terrortylor/nvim-comment",
    keys = { "<leader>", 'g' },
    config = function() require('plugs.util.comments') end,
    lazy = true,
  },
  -- The funs begins
  {
    "williamboman/mason.nvim",
    cmd = {
      "MasonInstall",
      "MasonUninstall",
      "Mason",
      lazy = true,
      "MasonUninstallAll",
      "MasonLog",
    },
    config = function() require('plugs.lsp.mason') end,
  },
  -- Mason Lspconfig bridge
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
  },
  -- Easily configure lsp
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "CursorHold" },
    lazy = true,
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
    config = function()
      require "plugs.lsp.lspconfig"
    end,
  },
  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        lazy = true,
        config = function()
          require("plugs.lsp.luasnip")
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        event = "InsertEnter",
        lazy = true,
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    config = function()
      require("plugs.lsp.cmp")
    end,
  },
  -- Nix expressions vim
  {
    "LnL7/vim-nix",
    lazy = true,
    ft = 'nix',
  },
  -- Custom ui select for telescope (used for colorscheme changer and other stuff)
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true
  },
  -- Quickly switch projects with telescope
  {
    'nvim-telescope/telescope-project.nvim',
    lazy = true
  },
  -- Folds
  {
    'kevinhwang91/nvim-ufo',
    lazy = true,
    event = 'CursorHold',
    dependencies = 'kevinhwang91/promise-async'
  },
  -- Symbols outline
  {
    'simrat39/symbols-outline.nvim',
    cmd = "SymbolsOutline",
    lazy = true,
    config = function() require("plugs.util.symbols") end
  },
  -- Show info at the end of closing backets
  {
    'code-biscuits/nvim-biscuits',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    lazy = true,
    config = function() require("plugs.lsp.biscuits") end,
    event = 'CursorHold',
  },
  -- Tagging important files
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    config = function() require("plugs.util.grapple") end,
    cmd = {
      "GrappleCycle",
      "GrapplePopup",
      "GrappleReset",
      "GrappleSelect",
      "GrappleTag",
      "GrappleTags",
      "GrappleToggle",
      "GrappleUntag"
    }
  },
  -- Hop anyhwere easily
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    lazy = true,
    cmd = {
      "HopAnywhere",
      "HopChar1",
      "HopChar2",
      "HopLine",
      "HopLineStart",
      "HopVertical",
      "HopWord"
    },
    config = function() require("plugs.util.hop") end
  },
  -- Dashboard
  {
    "goolord/alpha-nvim",
    lazy = true,
    cmd = {
      "Alpha",
      "AlphaRedraw"
    },
    config = function()
      require("plugs.ui.alpha")
    end
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function() require("plugs.lsp.saga") end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  -- Pictograms for lsp
  {
    "onsails/lspkind.nvim",
    event = "InsertEnter",
  },
  -- Lazygit implementation
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "LazyGit"
    },
    lazy = true,
  },
  -- Git plugin
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = 'CursorHold',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = {
            hl = 'GitSignsAdd',
            text = '│',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn'
          },
          change       = {
            hl = 'GitSignsChange',
            text = '│',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
          },
          delete       = {
            hl = 'GitSignsDelete',
            text = '_',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
          },
          topdelete    = {
            hl = 'GitSignsDelete',
            text = '‾',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
          },
          changedelete = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
          },
          untracked    = {
            hl = 'GitSignsAdd',
            text = '│',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsDeleteLn'
          },
        },
        current_line_blame = true,
      }
    end
  },
  -- Discord rich presence
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require "plugs.util.presence"
    end,
  },
  -- Fold easily
  {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost", -- later or on keypress would prevent saving folds
    opts = true,           -- needed even when using default config
  },
  -- Pick font awesome incons
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
    cmd = {
      "IconPickerNormal",
      "IconPickerYank",
      "IconPickerInsert"
    },
  },
  -- Change the UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("plugs.ui.noice")
    end,
    lazy = true,
  },
  -- Search and replace text
  {
    'nvim-pack/nvim-spectre',
    config = function()
      require("plugs.util.spectre")
    end,
    lazy = true,
  },
  -- Sessions
  {
    'olimorris/persisted.nvim',
    cmd = {
      "SessionSave",
      "SessionLoadLast",
      "SessionLoad"
    },
    config = true,
    lazy = true,
  },
  -- Read devdocs rom nvim
  {
    'luckasRanarison/nvim-devdocs',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "DevdocsInstall",
      "DevdocsOpen",
      "DevdocsOpenFloat"
    },
    opts = {},
    lazy = true,
  },
  -- Remote coding sessions
  {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    config = function()
      require('distant'):setup()
    end,
    lazy = true,
  },
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    lazy = true,
  },
  -- Worktree manager for git
  {
    'ThePrimeagen/git-worktree.nvim',
    lazy = true,
  },
  -- Hide the code that is not active
  {
    "folke/twilight.nvim",
    cmd = {
      "TwilightEnable",
      "TwilightDisable",
      "Twilight"
    },
    lazy = true,
  },
  -- Show recent changes to undo
  {
    'mbbill/undotree',
    cmd = {
      "UndotreeToggle"
    },
    lazy = true,
  },
  {
    "dharmx-lua/track.nvim",
    lazy = true,
  }
})
