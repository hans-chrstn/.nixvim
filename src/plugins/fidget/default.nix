{
  lib,
  config,
  ...
}: let
  cfg = config.fidget;
in {
  options.fidget = {
    enable = lib.mkEnableOption "Enable the fidget plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins.fidget = {
      enable = true;
      settings = {
      };
    };
  };
}
