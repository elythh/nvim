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

      if require("nixCatsUtils").isNixCats then
        for server_name, _ in pairs(servers) do
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            settings = (servers[server_name] or {}).settings,
            filetypes = (servers[server_name] or {}).filetypes,
            cmd = (servers[server_name] or {}).cmd,
            root_pattern = (servers[server_name] or {}).root_pattern,
          }
        end
      else
        -- NOTE: nixCats: and if no nix, do it the normal way

        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu.
        require("mason").setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          "stylua", -- Used to format Lua code
        })
        require("mason-tool-installer").setup { ensure_installed = ensure_installed }

        require("mason-lspconfig").setup {
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              -- This handles overriding only values explicitly passed
              -- by the server configuration above. Useful when disabling
              -- certain features of an LSP (for example, turning off formatting for tsserver)
              server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
              require("lspconfig")[server_name].setup(server)
            end,
          },
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
        lua = { "stylua" },
        nix = { "nixfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { lsp_format = "prefer" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        rust = { "rustfmt" },
      },
    },
  },
}
