{
  lib,
  config,
  customPackages,
  ...
}: let
  cfg = config.cinnamon;
in {
  options.cinnamon = {
    enable = lib.mkEnableOption "Enable the cinnamon plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.visuals.cinnamon-nvim = {
      enable = true;
      setupOpts = {
        keymaps = {
          basic = true;
          extra = true;
        };
      };
    };
  };
}
