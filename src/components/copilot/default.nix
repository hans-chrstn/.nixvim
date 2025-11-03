{
  lib,
  config,
  ...
}: let
  cfg = config.copilot;
in {
  options.copilot = {
    enable = lib.mkEnableOption "Enable the copilot plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.assistant.copilot = {
        enable = true;
        setupOpts = {
          panel = {
            enabled = false;
            layout.position = "bottom";
            layout.ratio = 0.4;
          };
          suggestion = {
            enabled = false;
          };
        };
        mappings = {
        };
      };
    };
}
