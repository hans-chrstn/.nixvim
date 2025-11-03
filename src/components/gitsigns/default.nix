{
  lib,
  config,
  ...
}: let
  cfg = config.gitsigns;
in {
  options.gitsigns = {
    enable = lib.mkEnableOption "Enable the gitsigns plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.git.gitsigns = {
        enable = true;
        setupOpts = {
          trouble = true;
          current_line_blame = false;
        };
        mappings = {
          blameLine     = "<leader>ghb";
          diffThis      = "<leader>ghd";
          previewHunk   = "<leader>ghp";
          resetBuffer   = "<leader>ghR";
          resetHunk     = "<leader>ghr";
          stageHunk     = "<leader>ghs";
          stageBuffer   = "<leader>ghS";
          undoStageHunk = "<leader>ghu";
        };
      };
    };
}
