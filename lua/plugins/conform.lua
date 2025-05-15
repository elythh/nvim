return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>fm",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			hcl = { "terraform_fmt" },
			lua = { "stylua" },
			nix = { "nixfmt" },
			markdown = { "prettierd" },
			sh = { "shfmt" },
			terraform = { "terraform_fmt" },
			yaml = { "yamlfmt", "yamllint" },
			python = { "ruff" },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Customize formatters
		formatters = {},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
