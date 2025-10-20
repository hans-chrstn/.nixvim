{ lib, config, ... }:

let
  cfg = config.cord;
in
{
  options.cord = {
    enable = lib.mkEnableOption "Enable the cord plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      cord.enable = true;
    };
    extraConfigLua = '''';
  };
}
