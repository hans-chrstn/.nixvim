{
  lib,
  config,
  ...
}: let
  cfg = config.comment;
in {
  options.comment = {
    enable = lib.mkEnableOption "Enable the comment plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.comments.comment-nvim = {
        enable = true;
        setupOpts.mappings = {
          basic = true;
          extra = true;
        };
      };
    };
}
