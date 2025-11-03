{ lib, config, customPackages, ... }:

let
  cfg = config.NEW_COMPONENT_NAME;
in
{
  options.NEW_COMPONENT_NAME = {
    enable = lib.mkEnableOption "Enable the NEW_COMPONENT_NAME plugin";
  };

  config = lib.mkIf cfg.enable {
  };
}
