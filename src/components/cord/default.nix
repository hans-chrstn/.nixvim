{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.cord;
in {
  options.cord = {
    enable = lib.mkEnableOption "Enable the cord plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.lazy.plugins = {
      "cord.nvim" = {
        package = pkgs.vimPlugins.cord-nvim;
        setupModule = "cord";
        setupOpts = {
        };

        lazy = true;

        event = ["BufWinEnter"];
      };
    };
  };
}
