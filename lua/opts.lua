local opt = vim.opt
local g = vim.g
local opts = {}

opts.initial = function()
  g.mapleader = " "

  opt.laststatus = 3 -- global statusline
  opt.showmode = false

  opt.clipboard = "unnamedplus"

  opt.expandtab = true
  opt.shiftwidth = 2
  opt.smartindent = true
  opt.tabstop = 2
  opt.softtabstop = 2

  vim.opt.fillchars = { eob = " " }
  opt.ignorecase = true
  opt.smartcase = true
  opt.mouse = "a"

  opt.number = true
  opt.relativenumber = true

  opt.signcolumn = "yes"
  opt.splitbelow = true
  opt.splitright = true
  opt.termguicolors = true
  vim.o.updatetime = 500
  opt.timeoutlen = 400
  opt.undofile = true
  opt.cursorline = true
  opt.scrolloff = 4

  g.loaded_netrw = 1
  g.loaded_netrwPlugin = 1
end

opts.final = function()
  -- mason, write correct names only
  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd "MasonInstall css-lsp html-lsp lua-language-server typescript-language-server stylua prettier"
  end, {})

  -- format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format { bufnr = args.buf }
    end,
  })

  vim.diagnostic.config {
    underline = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = {
      text = {
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.WARN] = "",
      },
    },
  }

  -- auto indent on <tab>
  vim.keymap.set("i", "<tab>", function()
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()

    -- this assume that "!^F" is in the "indentkeys" option
    if vim.o.indentexpr ~= "" and col == 0 and line:match "^%s*$" then
      local ctrl_f = vim.api.nvim_replace_termcodes("<c-f>", true, false, true)
      vim.api.nvim_feedkeys(ctrl_f, "n", false)
    else
      local tab = vim.api.nvim_replace_termcodes("<tab>", true, false, true)
      vim.api.nvim_feedkeys(tab, "n", false)
    end
  end)

  -- Define a custom namespace for diagnostics styling
  local diagnostic_ns = vim.api.nvim_create_namespace "DiagnosticFloat"

  -- Define a custom highlight group just for diagnostics float
  vim.api.nvim_set_hl(0, "DiagnosticNormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloatBorder", { fg = "#89b4fa" })

  -- Function to show diagnostic float with custom highlights
  local function show_custom_diagnostic_float()
    local opts = {
      focusable = false,
      source = "if_many",
      border = "rounded",
    }

    -- Temporarily override NormalFloat and FloatBorder just for this window
    vim.diagnostic.open_float(nil, opts)

    -- Get the most recent float window
    local float_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_option_value(
      "winhl",
      "NormalFloat:DiagnosticNormalFloat,FloatBorder:DiagnosticFloatBorder",
      { win = float_win }
    )
  end

  -- Create autocommand to trigger on CursorHold
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = show_custom_diagnostic_float,
  })

  -- add binaries installed by mason.nvim to path
  local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
  vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

  package.preload["nvim-web-devicons"] = function()
    require("mini.icons").mock_nvim_web_devicons()
    return package.loaded["nvim-web-devicons"]
  end
end

return opts
