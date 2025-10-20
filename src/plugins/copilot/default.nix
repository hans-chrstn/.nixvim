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

  config = lib.mkIf cfg.enable {
    plugins.copilot-lua = {
      enable = true;
      settings = {
        panel = {
          enabled = false;
          autoRefresh = true;
          layout = {
            position = "bottom";
            ratio = 0.4;
          };
        };
        suggestion = {
          enabled = false;
          autoTrigger = true;
          debounce = 75;
          keymap = {
            accept = "<M-l>";
            acceptWord = false;
            acceptLine = false;
            next = "<M-]>";
            prev = "<M-[>";
            dismiss = "<C-]>";
          };
        };

        filetypes = {
          yaml = false;
          markdown = false;
          help = false;
          gitcommit = false;
          gitrebase = false;
          hgcommit = false;
          svn = false;
          cvs = false;
          "." = false;
        };

        copilotNodeCommand = "node";
        serverOptsOverrides = { };
      };
    };
    extraConfigLua = '''';
  };
}
