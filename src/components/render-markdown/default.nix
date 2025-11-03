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
    vim.languages.markdown.extensions.render-markdown-nvim = {
      enable = true;
    };
  };
}
