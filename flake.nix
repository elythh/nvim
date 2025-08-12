{
  description = "IceNvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  # see :help nixCats.flake.outputs
  outputs =
    {
      # self,
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = {
        # allowUnfree = true;
      };
      dependencyOverlays = # (import ./overlays inputs) ++
        [
          (utils.standardPluginOverlay inputs)
        ];

      categoryDefinitions =
        {
          pkgs,
          # settings,
          # categories,
          # extra,
          # name,
          # mkNvimPlugin,
          ...
        }:
        {
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              nixd
              nix-doc
              stdenv.cc.cc
              typescript-language-server
              vtsls
              lua-language-server
              svelte-language-server
              astro-language-server
              tailwindcss-language-server
              stylua
              ripgrep
              # broken nixpkg
              # rust-analyzer
              vscode-langservers-extracted
              cmake-language-server
              emmet-language-server
              gopls
            ];
          };

          startupPlugins = {
            # gitPlugins = with pkgs.neovimPlugins; [ ];
            general = with pkgs.vimPlugins; [
              lazy-nvim
              snacks-nvim
              nvim-lspconfig
              plenary-nvim
              mini-icons
              nvim-tree-lua
              mason-nvim
              blink-cmp
              (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars))
              lazydev-nvim
              conform-nvim
              friendly-snippets
              {
                name = "LuaSnip";
                plugin = luasnip;
              }
              nvim-autopairs
              nvim-ts-autotag
              nvim-ts-context-commentstring
              vim-sleuth
              refactoring-nvim
              which-key-nvim
              bufferline-nvim
              lualine-nvim
              gitsigns-nvim
              noice-nvim
              nui-nvim
              nvim-notify
              render-markdown-nvim
              markdown-preview-nvim
              {
                name = "catppuccin";
                plugin = catppuccin-nvim;
              }
              tokyonight-nvim
            ];
          };

          # optionalPlugins = {
          #   gitPlugins = with pkgs.neovimPlugins; [ ];
          #   general = with pkgs.vimPlugins; [ ];
          # };

          sharedLibraries = {
            general = with pkgs; [
              lazygit

            ];
          };

          environmentVariables = {
            test = {
              CATTESTVAR = "It worked!";
            };
          };

          extraWrapperArgs = {
            test = [
              ''--set CATTESTVAR2 "It worked again!"''
            ];
          };

          extraPython3Packages = {
            test = (_: [ ]);
          };
          extraLuaPackages = {
            test = [ (_: [ ]) ];
          };
        };

      packageDefinitions = {
        nvim =
          { pkgs, ... }:
          {
            settings = {
              wrapRc = true;
              aliases = [
                "vim"
                "nv"
              ];
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            categories = {
              general = true;
              gitPlugins = true;
              customPlugins = true;
              test = true;
              example = {
                youCan = "add more than just booleans";
                toThisSet = [
                  "and the contents of this categories set"
                  "will be accessible to your lua with"
                  "nixCats('path.to.value')"
                  "see :help nixCats"
                ];
              };
            };
          };
      };
      defaultPackageName = "nvim";
    in

    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = utils.mkAllWithDefault defaultPackage;

        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = '''';
          };
        };

      }
    )
    // (
      let
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
        homeModule = utils.mkHomeModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
      in
      {
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      }
    );
}
