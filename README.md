# IcyVim
- Minimal neovim config using TinyVim as the base and nixCats for nix and home-manager integration
- This also contains some of my personal tweaks

![screenshot](https://files.catbox.moe/hgjuqx.png)

## :sparkles: Features
### Lazy plugin management

this configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) to manage plugins.

### integrated plugins

- :palm_tree: [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) -  a file explorer tree for neovim written in lua 
- :page_facing_up: [bufferline](https://github.com/akinsho/bufferline.nvim) - a snazzy bufferline for Neovim 
- :airplane: [lualine](https://github.com/nvim-lualine/lualine.nvim) - a blazing fast and easy to configure neovim statusline plugin.
- :evergreen_tree: [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - treesitter configurations and abstraction layer for neovim.
- :cat: [catppuccin-nvim](https://github.com/catppuccin/nvim) - soothing pastel theme for (neo)vim 
- :eye: [blink.cmp](https://github.com/Saghen/blink.cmp) - a completion plugin for neovim.
- :popcorn: [snacks.nvim](https://github.com/folke/snacks.nvim) - a collection of QoL plugins for Neovim 
- :scissors: [luasnip](https://github.com/L3MON4D3/LuaSnip) with [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - a snippet engine for neovim.
- :compass: [mini.surround](https://github.com/echasnovski/mini.surround) - neovim Lua plugin with fast and feature-rich surround actions
- :hammer: [mini.icons](https://github.com/echasnovski/mini.icons) - icon provider 
- :desktop_computer: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - quickstart configs for nvim lsp
- :checkered_flag: [conform](https://github.com/stevearc/conform.nvim) - lightweight yet powerful formatter plugin for neovim
- :telescope: [telescope](https://github.com/nvim-telescope/telescope.nvim) - a highly extendable fuzzy finder.
- :vertical_traffic_light: [gitsigns](https://github.com/lewis6991/gitsigns.nvim) - git integration for neovim.
- :scroll: [which-key](https://github.com/folke/which-key.nvim) - a keymap ui for neovim.
- :collision: [noice](https://github.com/folke/noice.nvim) - highly experimental plugin that completely replaces the ui for messages, cmdline and the popupmenu. 
- :zap: [flash](https://github.com/folke/flash.nvim) - navigate your code with search labels, enhanced character motions and treesitter integration 
- :arrow_right_hook: [inc-rename](https://github.com/smjonas/inc-rename.nvim) - incremental lsp renaming based on neovim's command-preview feature. 


# 📦 Install
- This is not meant to be used without nix, but I am pretty sure it works ok.

1. In your `flake.nix`
```nix
{
  inputs = {
    neovim.url = "git+ssh://git@github.com/lalit64/nvim.git";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  }
}
```

2. Use the home-manager module by including it in the imports like this:
```nix
imports = [
  inputs.neovim.homeModules.default
  { neovim.enable = true }
];
```

Make sure you don't have neovim or vim installed
