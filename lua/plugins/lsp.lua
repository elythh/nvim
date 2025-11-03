return {
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
        beacon = {
          enable = true,
        },
        ui = {
          border = "rounded",
          codeAction = "💡",
        },
        hover = {
          openCmd = "!floorp",
          openLink = "gx",
        },
        diagnostic = {
          borderFollow = true,
          diagnosticOnlyCurrent = false,
          showCodeAction = true,
        },
        symbolInWinbar = {
          enable = true,
        },
        codeAction = {
          extendGitSigns = false,
          showServerName = true,
          onlyInCursor = true,
          numShortcut = true,
          keys = {
            exec = "<CR>",
            quit = {
              "<Esc>",
              "q",
            },
          },
        },
        lightbulb = {
          enable = false,
          sign = false,
          virtualText = true,
        },
        implement = {
          enable = false,
        },
        rename = {
          autoSave = false,
          keys = {
            exec = "<CR>",
            quit = {
              "<C-k>",
              "<Esc>",
            },
            select = "x",
          },
        },
        outline = {
          autoClose = true,
          autoPreview = true,
          closeAfterJump = true,
          layout = "normal",
          winPosition = "right",
          keys = {
            jump = "e",
            quit = "q",
            toggleOrJump = "o",
          },
        },
        scrollPreview = {
          scrollDown = "<C-f>",
          scrollUp = "<C-b>",
        },
      }
    end,
  }, -- <--- ADDED MISSING COMMA HERE to separate lspsaga from the next plugin

  { "diogo464/kubernetes.nvim" },
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    lazy = false,
    opts = {
      formatters_by_ft = {
        hcl = { "terraform_fmt" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        markdown = { "prettierd" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        yaml = {},
        python = { "ruff" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        gitcommit = { "commitlint" },
        yaml = { "yamllint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
