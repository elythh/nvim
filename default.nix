{
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [ ];
    config.allowUnfree = true;
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,

  # wow this is hacky
  self ? { },
  elvimVersion ? self.shortRev or self.dirtyRev or "unknown",
}:
let
  packages = lib.makeScope pkgs.newScope (self: {
    elvim = self.callPackage ./pkgs/elvim/package.nix { inherit elvimVersion; };
    elvimPlugins = self.callPackage ./pkgs/elvim-plugins/package.nix { };
    wrapNeovim = self.callPackage ./pkgs/wrap-neovim/package.nix { };
  });
in
packages
