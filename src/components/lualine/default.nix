{
  lib,
  config,
  ...
}: let
  cfg = config.lualine;
in {
  options.lualine = {
    enable = lib.mkEnableOption "Enable the lualine plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.statusline.lualine = {
      enable = true;
      setupOpts = {
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = [];
        };
      };
    };
  };
}
