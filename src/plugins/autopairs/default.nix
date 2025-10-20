{
  lib,
  config,
  ...
}: let
  cfg = config.autopairs;
in {
  options.autopairs = {
    enable = lib.mkEnableOption "Enable the autopairs plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins.nvim-autopairs = {
      enable = true;
    };
    extraConfigLua = '''';
  };
}
