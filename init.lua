if vim.loader then
  vim.loader.enable()
end

require("opts").initial()
require("lsp")
require("pack").setup()
