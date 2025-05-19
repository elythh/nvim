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

-- Gitlab
m("n", "<leader>glaa", ":lua require('gitlab').add_assignee()<CR>", { desc = "Add assignee" })
m("n", "<leader>glad", ":lua require('gitlab').delete_assignee()<CR>", { desc = "Remove assignee" })
m("n", "<leader>glal", ":lua require('gitlab').add_label()<CR>", { desc = "Add Label" })
m("n", "<leader>gldl", ":lua require('gitlab').delete_label()<CR>", { desc = "Delete Label" })
m("n", "<leader>glc", ":lua require('gitlab').choose_merge_request()<CR>", { desc = "Choose Merge Request" })
m("n", "<leader>gln", ":lua require('gitlab').create_mr()<CR>", { desc = "Create Merge Request" })
m("n", "<leader>glr", ":lua require('gitlab').review()<CR>", { desc = "Review Merge Request" })
m(
	"n",
	"<leader>gls",
	":lua require('gitlab').summary({ template_file = '.gitlab/merge_request_templates/Default.md'})<CR>",
	{ desc = "See Merge Request Summary" }
)
m("n", "<leader>glr", ":lua require('gitlab').approve()<CR>", { desc = "Approve Merge Request" })
m("n", "<leader>glr", ":lua require('gitlab').open_in_browser()<CR>", { desc = "Open Current Merge Request (browser)" })

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

vim.keymap.set("n", "<leader>q", function()
	require("quicker").toggle()
end, {
	desc = "Toggle quickfix",
})
vim.keymap.set("n", "<leader>l", function()
	require("quicker").toggle({ loclist = true })
end, {
	desc = "Toggle loclist",
})
