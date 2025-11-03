{
  lib,
  config,
  ...
}: let
  cfg = config.yazi;
in {
  options.yazi = {
    enable = lib.mkEnableOption "Enable the yazi plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.utility.yazi-nvim = {
      enable = true;
      setupOpts = {
        open_for_directories = true;
        enable_mouse_support = true;
        floating_window_scaling_factor = 0.8;
        yazi_floating_window_border = "single";
        yazi_floating_window_winblend = 10;
      };
    };
  };
}
