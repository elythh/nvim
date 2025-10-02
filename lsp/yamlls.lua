return {
  cmd = {
    "yaml-language-server",
    "--stdio", -- Most standard language servers use stdio
  },
  filetypes = {
    "yaml",
    "yml",
  },
  root_markers = {
    ".git",
    ".yaml-lint.yml",
    "package.json", -- Common for projects using YAML config
  },
  settings = {
    yaml = {
      -- Example: Enable Kubernetes schema if needed
      schemas = {
        kubernetes = "/*.y(a)ml",
      },
      format = {
        enable = true,
      },
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
