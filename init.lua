if vim.loader then
  vim.loader.enable()
end

require("opts").initial()
require("lsp")
require("pack").setup(function()
  require("blink.cmp").build():pwait()

  require("plugins.colorscheme")
  require("plugins.snacks")
  require("plugins.blink")
  require("plugins.mini")
  require("plugins.ui")
  require("plugins.lsp-tools")
  require("plugins.misc")

  require("plugins.scrollEOF").setup({})
  require("opts").final()
  require("mappings").general()
  require("mappings").lsp()
  require("mappings").misc()
  require("mappings").mini()
end)
