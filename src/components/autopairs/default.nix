{
  lib,
  config,
  ...
}: let
  cfg = config.autopairs;
in {
  options.autopairs = {
    enable = lib.mkEnableOption "Enable the autopairs plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.autopairs.nvim-autopairs = {
        enable = true;
      };
    };
}
