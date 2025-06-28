self:
{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.elvim;

  pkgs' = import ../default.nix { inherit pkgs self; };
in
{
  options = {
    programs.elvim = {
      enable = lib.mkEnableOption "elvim";

      package = lib.mkPackageOption pkgs' "elvim" { };

      includePerLanguageTooling = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to include per-language tooling in elvim.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.elvim = {
      package = pkgs'.elvim.override {
        inherit (cfg) includePerLanguageTooling;
      };
    };

    home.packages = [ cfg.package ] ++ lib.optional cfg.gui.enable cfg.gui.package;
  };
}
