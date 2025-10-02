-- gopls configuration
return {
  cmd = {
    "gopls",
  },
  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl", -- For Go templates, common in many Go projects
  },
  root_markers = {
    ".git",
    "go.mod", -- Primary marker for Go modules
    "go.work", -- For multi-module workspaces
  },
  settings = {
    gopls = {
      -- Example gopls specific settings
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      buildFlags = {}, -- Can be used to pass specific build flags
      hints = {
        constant = true,
        functionType = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
  single_file_support = false, -- Go is typically project-based using modules
  log_level = vim.lsp.protocol.MessageType.Warning,
}
