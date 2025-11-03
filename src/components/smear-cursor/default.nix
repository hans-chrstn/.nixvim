{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.smear-cursor;
in {
  options.smear-cursor = {
    enable = lib.mkEnableOption "Enable the smear-cursor plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.lazy.plugins = {
      "smear-cursor.nvim" = {
        package = pkgs.vimPlugins.smear-cursor-nvim;
        lazy = false;
        setupModule = "smear_cursor";
        setupOpts = {
          smear_between_buffers = true;

          smear_between_neighbor_lines = true;

          use_floating_windows = true;

          legacy_computing_symbols_support = false;

          hide_target_hack = true;
        };
      };
    };
  };
}
