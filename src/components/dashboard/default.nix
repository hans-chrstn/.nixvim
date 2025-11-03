{
  lib,
  config,
  ...
}: let
  cfg = config.dashboard;
in {
  options.dashboard = {
    enable = lib.mkEnableOption "Enable the dashboard plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.dashboard.dashboard-nvim = {
        enable = true;
        setupOpts = {
          theme = "hyper";
          config = {
            header = [
              "╔────────────────────────────────────────────────────────────────────╗"
              "│                                                                    │"
              "│  ███▄ ▄███▓ ▄▄▄      ▓█████▄ ▓█████  ██▓     ██▓ ███▄    █ ▓█████  │"
              "│ ▓██▒▀█▀ ██▒▒████▄    ▒██▀ ██▌▓█   ▀ ▓██▒    ▓██▒ ██ ▀█   █ ▓█   ▀  │"
              "│ ▓██    ▓██░▒██  ▀█▄  ░██   █▌▒███   ▒██░    ▒██▒▓██  ▀█ ██▒▒███    │"
              "│ ▒██    ▒██ ░██▄▄▄▄██ ░▓█▄   ▌▒▓█  ▄ ▒██░    ░██░▓██▒  ▐▌██▒▒▓█  ▄  │"
              "│ ▒██▒   ░██▒ ▓█   ▓██▒░▒████▓ ░▒████▒░██████▒░██░▒██░   ▓██░░▒████▒ │"
              "│ ░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒▒▓  ▒ ░░ ▒░ ░░ ▒░▓  ░░▓  ░ ▒░   ▒ ▒ ░░ ▒░ ░ │"
              "│ ░  ░      ░  ▒   ▒▒ ░ ░ ▒  ▒  ░ ░  ░░ ░ ▒  ░ ▒ ░░ ░░   ░ ▒░ ░ ░  ░ │"
              "│ ░      ░     ░   ▒    ░ ░  ░    ░     ░ ░    ▒ ░   ░   ░ ░    ░    │"
              "│        ░         ░  ░   ░       ░  ░    ░  ░ ░           ░    ░  ░ │"
              "│                       ░                                            │"
              "│                                                                    │"
              "╚────────────────────────────────────────────────────────────────────╝"
            ];
            mru = {
              limit = 10;
              icon = " ";
              label = " Recently Used:";
              cwd_only = false;
            };
            project = {
              enable = true;
              limit = 8;
              icon = " ";
              label = " Projects:";
              action = "Telescope find_files cwd=";
            };
            week_header.enable = false;
            shortcut = [
              {
                desc = "󰭎 Search";
                group = "Label";
                action = "Telescope find_files";
                key = "f";
              }
              {
                desc = "󰍉 Word Search";
                group = "Label";
                action = "Telescope live_grep";
                key = "l";
              }
              {
                desc = " Recent Files";
                group = "Label";
                action = "Telescope oldfiles";
                key = "o";
              }
              {
                desc = " New File";
                group = "Label";
                action = lib.mkLuaInline ''
                  function()
                    local filename = vim.fn.input("Enter filename: ")
                    if filename ~= "" then
                      vim.cmd("edit " .. filename)
                    else
                      print("Filename cannot be empty")
                    end
                  end
                '';
                key = "n";
              }
              {
                desc = "󰩈 Exit";
                group = "Label";
                action = "q";
                key = "q";
              }
            ];
          };
        };
      };
    };
}
