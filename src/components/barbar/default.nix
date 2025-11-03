{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.barbar;
in {
  options.barbar = {
    enable = lib.mkEnableOption "Enable the barbar plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.lazy.plugins = {
      "barbar.nvim" = {
        package = pkgs.vimPlugins.barbar-nvim;
        setupModule = "barbar";
        setupOpts = {
          insert_at_end = true;
        };

        lazy = true;

        cmd = ["BufferNext" "BufferPrevious"];

        event = ["BufReadPost"];

        keys = [
        ];
      };
    };
  };
}
