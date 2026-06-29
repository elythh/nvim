local M = {}

local plugins = {
  "nvim-lua/plenary.nvim",
  "b0o/schemastore.nvim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "kiyoon/treesitter-indent-object.nvim",
  "nvim-treesitter/nvim-treesitter",
  "iamcco/markdown-preview.nvim",
  "allaman/kustomize.nvim",
  "ruifm/gitlinker.nvim",
  "f-person/git-blame.nvim",
  "folke/sidekick.nvim",
  "ramilito/kubectl.nvim",
  "allaman/tf.nvim",
  "aikhe/wrapped.nvim",
  "nvzone/volt",
  "christoomey/vim-tmux-navigator",
  "ibhagwan/fzf-lua",
  "harrisoncramer/gitlab.nvim",
  "MunifTanjim/nui.nvim",
  "sindrets/diffview.nvim",
  "stevearc/dressing.nvim",
  "nvim-tree/nvim-web-devicons",
  "disrupted/blink-cmp-conventional-commits",
  "mikavilpas/blink-ripgrep.nvim",
  "fang2hou/blink-copilot",
  "Kaiser-Yang/blink-cmp-git",
  "A7Lavinraj/fyler.nvim",
  "nvim-mini/mini.hipatterns",
  "nvim-mini/mini.icons",
  "nvim-mini/mini.sessions",
  "nvim-mini/mini.diff",
  "nvim-mini/mini.ai",
  "nvim-mini/mini.pairs",
  "nvim-mini/mini.clue",
  "nvim-mini/mini.visits",
  "nvim-mini/mini.extra",
  "akinsho/bufferline.nvim",
  "nvim-lualine/lualine.nvim",
  "folke/noice.nvim",
  "folke/tokyonight.nvim",
  "nvimdev/lspsaga.nvim",
  "diogo464/kubernetes.nvim",
  "stevearc/conform.nvim",
  "mfussenegger/nvim-lint",
  "folke/snacks.nvim",
}

local function wait_for_plugins(callback, attempts)
  attempts = attempts or 0
  if attempts > 600 then
    vim.notify("plugin installation timed out", vim.log.levels.ERROR)
    callback()
    return
  end
  local ok, _ = pcall(require, "nvim-treesitter")
  if ok then
    callback()
  else
    vim.defer_fn(function()
      wait_for_plugins(callback, attempts + 1)
    end, 100)
  end
end

function M.setup(callback)
  if type(vim.pack) ~= "table" or type(vim.pack.add) ~= "function" then
    error("vim.pack is not available in this Neovim build")
  end

  vim.pack.add({
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
  }, { load = true })

  local repos = {}
  for _, repo in ipairs(plugins) do
    repos[#repos + 1] = { src = ("https://github.com/%s.git"):format(repo) }
  end
  vim.pack.add(repos, { load = true, confirm = false })

  wait_for_plugins(callback)
end

return M
