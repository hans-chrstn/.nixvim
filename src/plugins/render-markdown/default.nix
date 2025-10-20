{
  lib,
  config,
  ...
}: let
  cfg = config.render-markdown;
in {
  options.render-markdown = {
    enable = lib.mkEnableOption "Enable the render-markdown plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins.render-markdown = {
      enable = true;
    };
    extraConfigLua = '''';
  };
}
