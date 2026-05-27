local M = {}

local function apply_keys(keys)
  for _, map in ipairs(keys or {}) do
    if type(map) == "table" and type(map[1]) == "string" and map[2] ~= nil then
      vim.keymap.set(map.mode or "n", map[1], map[2], {
        desc = map.desc,
        expr = map.expr,
        noremap = map.remap ~= true,
        silent = map.silent ~= false,
      })
    end
  end
end

function M.setup()
  local colorscheme = require("plugins.colorscheme")[1]
  colorscheme.config()

  local snacks = require "plugins.snacks"
  require("snacks").setup(snacks.opts)

  local blink = require("plugins.blink")[1]
  require("blink.cmp").setup(blink.opts)
  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  for _, spec in ipairs(require "plugins.mini") do
    if type(spec.config) == "function" then
      spec.config()
    end
  end

  local ui = require "plugins.ui"
  require("bufferline").setup(ui[1].opts)
  apply_keys(ui[1].keys)
  ui[2].config()
  require("noice").setup(ui[3].opts)

  local lsp = require "plugins.lsp"
  lsp[1].config()
  require("conform").setup(lsp[3].opts)
  lsp[4].config()

  local misc = require "plugins.misc"
  misc[5].config()
  require("kustomize").setup(misc[7].opts)
  misc[9].config()
  local git_blame_opts = misc[10].opts()
  for key, value in pairs(git_blame_opts) do
    vim.g["gitblame_" .. key] = value
  end
  require("fyler").setup(misc[11].opts)
  require("sidekick").setup(misc[12].opts)
  apply_keys(misc[12].keys)
  misc[13].config()
  require("tf").setup(misc[14].opts)
  require("wrapped").setup(misc[15].opts)
  apply_keys(misc[16].keys)
  require("fzf-lua").setup(misc[17].opts)
  apply_keys(misc[17].keys)
  misc[18].config()

  require("plugins.scrollEOF").setup {}
  require("opts").final()
  require("mappings").general()
  require("mappings").lsp()
  require("mappings").misc()
  require("mappings").mini()
end

return M
