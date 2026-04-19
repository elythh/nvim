local M = {}

M.specs = {
  require "plugins.misc",
  require "plugins.blink",
  require "plugins.mini",
  require "plugins.ui",
  require "plugins.colorscheme",
  require "plugins.lsp",
  require "plugins.snacks",
}

local function flatten(items, out)
  out = out or {}
  for _, item in ipairs(items or {}) do
    if type(item) == "table" and item[1] == nil then
      table.insert(out, item)
    elseif type(item) == "table" and type(item[1]) == "string" then
      table.insert(out, item)
    elseif type(item) == "table" then
      flatten(item, out)
    elseif type(item) == "string" then
      table.insert(out, { item })
    end
  end
  return out
end

local function repo_name(repo)
  local tail = repo:gsub("^.*/", "")
  tail = tail:gsub("%.git$", "")
  tail = tail:gsub("%.nvim$", "")
  tail = tail:gsub("^nvim%-", "")
  return tail
end

local function collect_repos(specs)
  local seen = {}
  local repos = {}
  local function to_src(repo)
    if repo:find("://", 1, true) then
      return repo
    end
    return ("https://github.com/%s.git"):format(repo)
  end

  local function add(repo)
    if type(repo) ~= "string" or repo == "options" or seen[repo] then
      return
    end
    seen[repo] = true
    table.insert(repos, { src = to_src(repo) })
  end

  for _, spec in ipairs(specs) do
    add(spec[1])
    if type(spec.dependencies) == "table" then
      for _, dep in ipairs(spec.dependencies) do
        add(type(dep) == "string" and dep or dep[1])
      end
    elseif type(spec.requires) == "string" then
      add(spec.requires)
    end
  end

  return repos
end

local function install_plugins(specs)
  if type(vim.pack) ~= "table" or type(vim.pack.add) ~= "function" then
    error "vim.pack is not available in this Neovim build"
  end
  local repos = collect_repos(specs)
  if #repos > 0 then
    vim.pack.add(repos, { load = true, confirm = false })
  end
end

local function load_lua_from_plugins(specs)
  local seen = {}
  local plug_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt")
  local function add(repo)
    if type(repo) ~= "string" or repo == "options" or seen[repo] then
      return
    end
    seen[repo] = true
    local plugin_dir = repo:gsub("^.*/", ""):gsub("%.git$", "")
    local lua_dir = vim.fs.joinpath(plug_dir, plugin_dir, "lua")
    if vim.uv.fs_stat(lua_dir) ~= nil then
      package.path = package.path
        .. ";"
        .. vim.fs.joinpath(lua_dir, "?.lua")
        .. ";"
        .. vim.fs.joinpath(lua_dir, "?", "init.lua")
    end
  end

  for _, spec in ipairs(specs) do
    add(spec[1])
    if type(spec.dependencies) == "table" then
      for _, dep in ipairs(spec.dependencies) do
        add(type(dep) == "string" and dep or dep[1])
      end
    elseif type(spec.requires) == "string" then
      add(spec.requires)
    end
  end
end

local function apply_plugin(spec)
  if type(spec) ~= "table" then
    return
  end

  local repo = spec[1]

  local opts = spec.opts
  if type(opts) == "function" then
    opts = opts()
  end

  if type(spec.keys) == "table" then
    for _, map in ipairs(spec.keys) do
      if type(map) == "table" and type(map[1]) == "string" and map[2] ~= nil then
        local mode = map.mode or "n"
        local map_opts = {
          desc = map.desc,
          expr = map.expr,
          noremap = map.remap ~= true,
          silent = map.silent ~= false,
          nowait = map.nowait,
          buffer = map.buffer,
        }
        vim.keymap.set(mode, map[1], map[2], map_opts)
      end
    end
  end

  if type(spec.config) == "function" then
    spec.config(spec, opts)
    return
  end

  if repo == "f-person/git-blame.nvim" then
    if type(opts) == "table" then
      for key, value in pairs(opts) do
        vim.g["gitblame_" .. key] = value
      end
    end
    return
  end

  if opts ~= nil and type(repo) == "string" then
    local main = spec.main or repo_name(repo)
    local mod = require(main)
    if type(mod.setup) == "function" then
      mod.setup(opts)
    end
  end
end

function M.setup()
  local specs = flatten(M.specs)
  install_plugins(specs)
  load_lua_from_plugins(specs)
  for _, spec in ipairs(specs) do
    apply_plugin(spec)
  end
end

return M
