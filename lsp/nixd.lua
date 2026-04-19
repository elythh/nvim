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
      nixpkgs = {
        expr = [[import <nixpkgs> {}]],
      },
      formatting = {
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
