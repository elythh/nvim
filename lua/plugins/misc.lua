require("nvim-treesitter").setup({
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "html",
    "css",
    "typescript",
    "javascript",
    "svelte",
    "rust",
    "astro",
    "nix",
  },
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
})

-- treesitter-indent-object text objects
vim.keymap.set({ "x", "o" }, "ai", function()
  require("treesitter_indent_object.textobj").select_indent_outer()
end, { desc = "Select context-aware indent (outer)" })

vim.keymap.set({ "x", "o" }, "aI", function()
  require("treesitter_indent_object.textobj").select_indent_outer(true, "V")
  require("treesitter_indent_object.refiner").include_surrounding_empty_lines()
end, { desc = "Select context-aware indent (outer, line-wise)" })

vim.keymap.set({ "x", "o" }, "ii", function()
  require("treesitter_indent_object.textobj").select_indent_inner()
end, { desc = "Select context-aware indent (inner, partial range)" })

vim.keymap.set({ "x", "o" }, "iI", function()
  require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
end, { desc = "Select context-aware indent (inner, entire range) in line-wise visual mode" })

-- kustomize
require("kustomize").setup({
  build = {
    additional_args = { "--enable-helm", "--load-restrictor=LoadRestrictionsNone" },
  },
})

-- gitlinker
require("gitlinker").setup({
  callbacks = {
    ["github.com"] = require("gitlinker.hosts").get_github_type_url,
    ["gitlab.dnm.radiofrance.fr"] = require("gitlinker.hosts").get_github_type_url,
  },
})

-- git-blame
do
  local hl_cursor_line = vim.api.nvim_get_hl(0, { name = "CursorLine" })
  local hl_comment = vim.api.nvim_get_hl(0, { name = "Comment" })
  local hl_combined = vim.tbl_extend("force", hl_comment, { bg = hl_cursor_line.bg })
  vim.api.nvim_set_hl(0, "CursorLineBlame", hl_combined)
  vim.g.gitblame_message_template = " <author> • <date> • <summary>"
  vim.g.gitblame_date_format = "%r"
  vim.g.gitblame_virtual_text_column = 1
  vim.g.gitblame_enabled = true
  vim.g.gitblame_highlight_group = "CursorLineBlame"
end

-- sidekick
require("sidekick").setup({
  cli = {
    mux = {
      backend = "tmux",
      enabled = true,
    },
  },
})

vim.keymap.set({ "n", "v" }, "<tab>", function()
  if not require("sidekick").nes_jump_or_apply() then
    return "<Tab>"
  end
end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })

vim.keymap.set({ "n", "v" }, "<leader>aa", function()
  require("sidekick.cli").toggle()
end, { desc = "Sidekick Toggle CLI" })

vim.keymap.set({ "n", "v" }, "<leader>ac", function()
  require("sidekick.cli").toggle({ name = "claude", focus = true })
end, { desc = "Sidekick Claude Toggle" })

vim.keymap.set({ "n", "v" }, "<leader>ap", function()
  require("sidekick.cli").prompt()
end, { desc = "Sidekick Ask Prompt" })

-- kubectl
require("kubectl").setup()

-- tf.nvim
require("tf").setup({})

-- wrapped.nvim
require("wrapped").setup({})

-- vim-tmux-navigator
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

-- fzf-lua
require("fzf-lua").setup({
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
  defaults = {
    file_icons = "mini",
  },
  winopts = {
    border = "single",
    preview = {
      border = "single",
      scrollbar = false,
    },
  },
  hls = {
    backdrop = "FloatBorder",
  },
})

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "Grep live" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "Find oldfiles" })
vim.keymap.set("n", "<leader>bi", "<cmd>FzfLua<CR>", { desc = "FzfLua" })
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua lsp_references<CR>", { desc = "Find lsp references" })

-- fyler
require("fyler").setup({
  auto_confirm_simple_mutation = true,
  integrations = {
    icon = "mini_icons",
  },
})

-- gitlab
require("gitlab.server").build(true)
require("gitlab").setup()
