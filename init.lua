if vim.loader then
  vim.loader.enable()
end

require("opts").initial()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local plugins = require "plugins"

require("nixCatsUtils.lazyCat").setup(
  nixCats.pawsible { "allPlugins", "start", "lazy.nvim" },
  plugins,
  require "lazy_spec"
)
