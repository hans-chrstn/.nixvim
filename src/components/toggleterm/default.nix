{
  lib,
  config,
  ...
}: let
  cfg = config.toggleterm;
in {
  options.toggleterm = {
    enable = lib.mkEnableOption "Enable the toggleterm plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.terminal.toggleterm = {
        setupOpts = {
          autochdir = false;
          autoscroll = true;
        };
        mappings.open = "<leader>oo";
        lazygit = {
          enable = true;
          mappings.open = "<leader>gg";
        };
      };
    };
}
