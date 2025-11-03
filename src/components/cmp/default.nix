{
  lib,
  config,
  ...
}: let
  cfg = config.cmp;
in {
  options.cmp = {
    enable = lib.mkEnableOption "Enable the cmp plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
      };
    };
}
