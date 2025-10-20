{ lib, config, ... }:

let
  cfg = config.barbar;
in
{
  options.barbar = {
    enable = lib.mkEnableOption "Enable the barbar plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      barbar.enable = true;
      web-devicons.enable = true; # deps
    };
    extraConfigLua = ''
      require('barbar').setup({
        insert_at_end = true,
      })
    '';
  };
}
