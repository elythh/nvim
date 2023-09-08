require("prism"):setup({
  currentTheme = "verdant",
  customFiles = vim.fn.stdpath "config" .. "/lua/hls",
  transparent = false,
})
