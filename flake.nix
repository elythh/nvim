{
  description = "kevin's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          runtimeDeps = with pkgs; [
            hello
            gcc

            # needed for fzf
            fzf
            ripgrep

            # needed for blink
            curl
            git

            prettierd

            lua-language-server
            stylua

            markdown-oxide
          ];
          /*
            nixpkgs.wrapNeovimUnstable is a function which takes two arguments:
            a neovim packaged
            an attribute set which specifies any other configuration
          */
          nvim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
            pkgs.neovimUtils.makeNeovimConfig {
              # LOL THANKS CHATGPT
              customRC = ''
                set runtimepath^=${./.}
                lua << EOF
                  local config_path = "${./.}/lua"
                  package.path = config_path .. "/?.lua;" .. config_path .. "/?/init.lua;" .. package.path
                  dofile("${./.}/init.lua")
                EOF
              ''; # A custom .vimrc file for the new neovim configuration
            }
            // {
              wrapperArgs = [
                "--prefix"
                "PATH"
                ":"
                "${pkgs.lib.makeBinPath runtimeDeps}"
              ]; # See https://nixos.org/manual/nixpkgs/stable/#fun-makeWrapper
            }
          );
        in
        {
          default = nvim;
          neovim = nvim;
        }
      );
    };
}
