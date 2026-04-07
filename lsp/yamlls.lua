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
      schemas = {
        kubernetes = "/*.y(a)ml",
      },
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      format = {
        enable = true,
      },
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
