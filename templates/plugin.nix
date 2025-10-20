{ lib, config, ... }:

let
  cfg = config.NEW_PLUGIN_NAME;
in
{
  options.NEW_PLUGIN_NAME = {
    enable = lib.mkEnableOption "Enable the NEW_PLUGIN_NAME plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins = {

    };
    extraConfigLua = '''';
  };
}
