{
  lib,
  config,
  ...
}: let
  cfg = config.web-devicons;
in {
  options.web-devicons = {
    enable = lib.mkEnableOption "Enable the web-devicons plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.visuals.nvim-web-devicons = {
        enable = true;
      };
    };
}
