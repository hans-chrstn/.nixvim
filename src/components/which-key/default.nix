{
  lib,
  config,
  ...
}: let
  cfg = config.which-key;
in {
  options.which-key = {
    enable = lib.mkEnableOption "Enable the which-key plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.binds.whichKey = {
      enable = true;

      setupOpts = {
        icons = {
          breadcrumb = "»";
          group = "+";
          separator = "";
        };
        win = {
          border = "none";
        };
      };

      register = {
        "<leader>c" = "+code";
        "<leader>d" = "+debug";
        "<leader>f" = "+find/file";
        "<leader>g" = "+git";
        "<leader>q" = "+quit/session";
        "<leader>s" = "+search";
        "<leader><Tab>" = "+tab";
        "<leader>t" = "+test";
        "<leader>u" = "+ui";
        "<leader>w" = "+windows";
      };
    };
  };
}
