return {
  {
    "neovim/nvim-lspconfig",
    event = "VimEnter",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          { path = (nixCats.nixCatsPath or "") .. "/lua", words = { "nixCats" } },
        },
      },
    },
    config = function()
      require("mappings").lsp()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local servers = {
        pyright = {},
        cmake = {},
        gopls = {},
        html = {},
        jsonls = {},
        yamlls = {},
      }

      if require("nixCatsUtils").isNixCats then
        servers.nixd = {}
      else
        servers.rnix = {}
        servers.nil_ls = {}
      end

      servers.yamlls = {
        settings = {
          yaml = {
            format = { enable = true },
            validate = { enable = true },
          },
        },
      }

      servers.lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
            runtime = { version = "LuaJIT" },
            formatters = {
              ignoreComments = true,
            },
            signatureHelp = { enabled = true },
            diagnostics = {
              globals = { "nixCats", "vim", "Snacks" },
              disable = { "missing-fields" },
            },
            telemetry = { enabled = false },
          },
        },
      }

      for server_name, _ in pairs(servers) do
        require("lspconfig")[server_name].setup {
          capabilities = capabilities,
          settings = (servers[server_name] or {}).settings,
          filetypes = (servers[server_name] or {}).filetypes,
          cmd = (servers[server_name] or {}).cmd,
          root_pattern = (servers[server_name] or {}).root_pattern,
        }
      end

      vim.diagnostic.config {
        underline = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
        signs = {
          text = {
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.WARN] = "",
          },
        },
      }
    end,
  },

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
        yaml = { "yamlfmt", "yamllint" },
        python = { "ruff" },
      },
    },
  },
}
