{
  lib,
  config,
  ...
}: let
  cfg = config.toggleterm;
in {
  options.toggleterm = {
    enable = lib.mkEnableOption "Enable the toggleterm plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins.toggleterm = {
      enable = true;
      settings = {
        size = ''
          function(term)
            if term.direction == "horizontal" then
              return 15
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.4
            end
          end
        '';
        autochdir = false;
        autoscroll = true;
      };
    };
    extraConfigLua = '''';
  };
}
