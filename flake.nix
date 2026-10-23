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
          cargo
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
              # macOS limits unix socket paths to 104 bytes; nested nix-shell TMPDIRs
              # exceed it, so serverstart() fails (fzf-lua errors at startup)
              if [ -z "''${XDG_RUNTIME_DIR:-}" ] && [ "$(printf %s "''${TMPDIR:-}" | wc -c)" -gt 40 ]; then
                XDG_RUNTIME_DIR="/tmp/nvim-$(id -u)"
                mkdir -p "$XDG_RUNTIME_DIR"
                chmod 700 "$XDG_RUNTIME_DIR"
                export XDG_RUNTIME_DIR
              fi
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
