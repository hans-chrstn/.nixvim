{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.colorizer;
in {
  options.colorizer = {
    enable = lib.mkEnableOption "Enable the colorizer plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.ui.colorizer.enable = true;
  };
}
