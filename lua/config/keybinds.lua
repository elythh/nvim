local m = vim.keymap.set

-- Turn off highlighting
m("n", "<Esc>", "<cmd>noh<CR>", { silent = true })

-- Window :3
m("n", "<C-h>", "<C-w>h")
m("n", "<C-l>", "<C-w>l")
m("n", "<C-j>", "<C-w>j")
m("n", "<C-k>", "<C-w>k")

-- Move up & down within wrapped line
m({ "n", "v" }, "k", [[v:count || mode(1)[0:1] == "no" ? "k" : "gk"]], { expr = true })
m({ "n", "v" }, "j", [[v:count || mode(1)[0:1] == "no" ? "j" : "gj"]], { expr = true })

-- Clipboard
m({ "n", "v" }, "<leader>y", [["+y]])
m("n", "<leader>Y", [["+Y]])

-- Greatest keybinds ever
m("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
m("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- QOL
m("n", "J", "mzJ`z")
m("v", "<", "<gv")
m("v", ">", ">gv")

-- Mini
m("n", "-", ":lua  MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>")

-- Quickfix
m("n", "[c", ":cnext<CR>")
m("n", "]c", ":cprev<CR>")

-- Toggle diagnostic text
m("n", "gK", function()
	local new_config = not vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = new_config })
end)

-- Theme switcher
local function switch_theme()
	vim.ui.input({ prompt = "Enter theme name: " }, function(theme_name)
		if not theme_name or theme_name == "" then
			return
		end

		-- Check if the theme file exists
		local theme_path = "themes." .. theme_name
		local success, _ = pcall(require, theme_path)

		if not success then
			vim.notify("Theme '" .. theme_name .. "' not found", vim.log.levels.ERROR)
			return
		end

		-- Set the global theme variable
		_G.theme = theme_name

		-- Reload the UI configuration to apply the new theme
		package.loaded["config.ui"] = nil
		require("config.ui")

		vim.notify("Switched to theme: " .. theme_name, vim.log.levels.INFO)
	end)
end
m("n", "<leader>tc", switch_theme, { desc = "Change theme" })
