require("prism"):setup({
  currentTheme = "cat",
  customFiles = vim.fn.stdpath "config" .. "/lua/hls",
  transparent = false,
  restart = false,
  reload = {},
})
