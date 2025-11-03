{
  lib,
  config,
  ...
}: let
  cfg = config.todo-comments;
in {
  options.todo-comments = {
    enable = lib.mkEnableOption "Enable the todo-comments plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.notes.todo-comments = {
      enable = true;
    };
  };
}
