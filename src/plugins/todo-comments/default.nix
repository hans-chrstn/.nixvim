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
    plugins.todo-comments = {
      enable = true;
    };
    extraConfigLua = '''';
  };
}
