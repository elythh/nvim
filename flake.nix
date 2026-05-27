{
  description = "ElythVim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSystem =
        f:
        nixpkgs.lib.genAttrs systems (system:
          f (import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          }));
      nvimDepsFor =
        pkgs: with pkgs; [
          neovim
          git
          ripgrep
          lua-language-server
          gopls
          yaml-language-server
          terraform-ls
          nixd
          stylua
          shfmt
          prettierd
          yamllint
          yamlfmt
          go
        ];
    in
    {
      packages = forEachSystem (
        pkgs:
        let
          nvimDeps = nvimDepsFor pkgs;

          nvimWithConfig = pkgs.writeShellApplication {
            name = "nvim";
            runtimeInputs = nvimDeps;
            text = ''
              unset VIMINIT
              export NVIM_APPNAME="elythvim"
              config_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/$NVIM_APPNAME"
              mkdir -p "$config_dir"
              cp -rf ${self}/* "$config_dir"/
              chmod -R u+w "$config_dir"
              exec nvim "$@"
            '';
          };
        in
        {
          default = nvimWithConfig;
          nvim = nvimWithConfig;
        }
      );

      apps = forEachSystem (pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/nvim";
        };
      });

      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = nvimDepsFor pkgs;
        };
      });
    };
}
