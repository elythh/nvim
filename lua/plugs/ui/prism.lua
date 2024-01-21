local cfg = require("core.cfg")

require("prism"):setup({
  customSchemes = cfg.customSchemes,
  currentTheme = "material",
  reset = false,
  customFiles = vim.fn.stdpath "config" .. "/lua/hls",
  transparent = true,
  reload = {},
})
