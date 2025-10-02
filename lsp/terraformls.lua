return {
  cmd = {
    "terraform-ls",
    "serve",
  },
  filetypes = {
    "terraform",
    "tf",
    "hcl", -- HCL is the underlying language
  },
  root_markers = {
    ".git",
    ".terraform", -- Directory created after 'terraform init'
    "main.tf",
  },
  settings = {
    terraform = {
      telemetry = {
        enabled = false,
      },
    },
  },
  single_file_support = false, -- Terraform projects are usually multi-file
  log_level = vim.lsp.protocol.MessageType.Warning,
}
