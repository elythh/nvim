local mason = require("mason")

local options = {
  ensure_installed = { "lua-language-server", "terraform-ls", "yamlfmt", "yamllint", "json-lsp", "jsonlint",
    "yaml-language-server" }, -- not an option from mason.nvim

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = "󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}



mason.setup(options)
