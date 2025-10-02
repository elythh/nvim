-- nixd configuration
return {
  cmd = {
    "nixd",
  },
  filetypes = {
    "nix",
  },
  root_markers = {
    ".git",
    "flake.nix",
    "default.nix",
    "configuration.nix",
  },
  settings = {
    nixd = {
      -- These settings likely rely on external variables like 'nixCats'
      nixpkgs = {
        -- Example of a setting to correctly locate nixpkgs
        expr = nixCats.extra("nixdExtras.nixpkgs") or [[import <nixpkgs> {}]],
      },
      options = {
        nixos = {
          expr = nixCats.extra("nixdExtras.nixos_options"),
        },
        ["home-manager"] = {
          expr = nixCats.extra("nixdExtras.home_manager_options"),
        },
        ["darwin"] = {
          expr = nixCats.extra("nixdExtras.darwin_options"),
        },
      },
      formatting = {
        -- Defines the command to use for document formatting
        command = { "nixfmt" },
      },
      diagnostic = {
        suppress = {
          "sema-escaping-with",
        },
      },
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
