# IceNvim 
- Extremly simple but functional neovim configuration

![screenshot](https://files.catbox.moe/3ug4xp.png)
![screenshot](https://files.catbox.moe/az3i2n.png)

### 💤 Lazy plugin management
This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) to manage plugins.

# 📦 Install
- This is not meant to be used without nix, but I am pretty sure it works ok.

> [!WARNING]
> Make sure you don't have neovim or vim installed

> [!NOTE]
> This installs an instance of neovim with all the plugins and config built

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
