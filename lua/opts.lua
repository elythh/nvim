local opt = vim.opt
local g = vim.g
local opts = {}

opts.initial = function()
  g.mapleader = " "

  opt.laststatus = 3
  opt.showmode = false

  opt.swapfile = false

  opt.clipboard = "unnamedplus"

  opt.expandtab = true
  opt.shiftwidth = 2
  opt.smartindent = true
  opt.tabstop = 2
  opt.softtabstop = 2

  opt.fillchars = { eob = " " }
  opt.ignorecase = true
  opt.smartcase = true
  opt.mouse = "a"

  opt.number = true
  opt.relativenumber = true

  vim.api.nvim_create_autocmd(
    { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
    { pattern = "*", command = "if &nu && mode() != 'i' | set rnu | endif" }
  )
  vim.api.nvim_create_autocmd(
    { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
    { pattern = "*", command = "if &nu | set nornu | endif" }
  )

  opt.signcolumn = "yes"
  opt.splitbelow = true
  opt.splitright = true
  opt.termguicolors = true
  vim.o.updatetime = 500
  opt.timeoutlen = 400
  opt.undofile = true
  opt.cursorline = true
  opt.scrolloff = 10

  vim.o.foldenable = true
  vim.o.foldlevel = 99
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.o.foldtext = ""
  opt.foldcolumn = "0"
  opt.fillchars:append({ fold = " " })

  g.loaded_netrw = 1
  g.loaded_netrwPlugin = 1
end

opts.final = function()
  vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = true,
    underline = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = true,
    },
    signs = {
      text = {
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.WARN] = "",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        [vim.diagnostic.severity.WARN] = "WarningMsg",
      },
    },
  })

  -- auto indent on <tab>
  vim.keymap.set("i", "<tab>", function()
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()

    if vim.o.indentexpr ~= "" and col == 0 and line:match("^%s*$") then
      local ctrl_f = vim.api.nvim_replace_termcodes("<c-f>", true, false, true)
      vim.api.nvim_feedkeys(ctrl_f, "n", false)
    else
      local tab = vim.api.nvim_replace_termcodes("<tab>", true, false, true)
      vim.api.nvim_feedkeys(tab, "n", false)
    end
  end)

  -- custom diagnostic float window highlight
  vim.api.nvim_set_hl(0, "DiagnosticNormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloatBorder", { fg = "#89b4fa" })

  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        source = "if_many",
        border = "rounded",
      })
      local float_win = vim.api.nvim_get_current_win()
      vim.api.nvim_set_option_value(
        "winhl",
        "NormalFloat:DiagnosticNormalFloat,FloatBorder:DiagnosticFloatBorder",
        { win = float_win }
      )
    end,
  })

  -- open help in a vertical split
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
      vim.cmd("wincmd L")
    end,
  })

  -- close Snacks prompt in insert mode by pressing escape
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "snacks_picker_input",
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "i", "<ESC>", "<ESC>:close!<CR>", { noremap = true, silent = true })
    end,
  })

  -- highlight yank text
  vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({ timeout = 500 })
    end,
  })

  -- enter git buffer in insert mode
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "gitrebase" },
    callback = function()
      vim.cmd("startinsert | 1")
    end,
  })

  -- q to quit on help
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help" },
    callback = function()
      vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = 0 })
    end,
  })

  -- disable new line autocomment
  vim.cmd([[autocmd FileType * set formatoptions-=ro]])

  -- prefer LSP folding if client supports it
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/foldingRange") then
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      end
    end,
  })

  -- add binaries installed by mason.nvim to path
  local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
  vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath("data") .. "/mason/bin"

  -- shim nvim-web-devicons to mini.icons
  package.preload["nvim-web-devicons"] = function()
    require("mini.icons").mock_nvim_web_devicons()
    return package.loaded["nvim-web-devicons"]
  end
end

return opts
