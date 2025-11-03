{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.noice;
in {
  options.noice = {
    enable = lib.mkEnableOption "Enable the noice plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.lazy.plugins = {
      "noice.nvim" = {
        package = pkgs.vimPlugins.noice-nvim;
        lazy = true;
        event = ["VimEnter"];
        priority = 50;
        setupModule = "noice";
        setupOpts = {
          cmdline = {
            enabled = true;
            view = "cmdline_popup";
            format = {
              cmdline = {
                pattern = "^:";
                icon = "";
                lang = "vim";
              };
              search_down = {
                kind = "search";
                pattern = "^/";
                icon = " ";
                lang = "regex";
              };
              search_up = {
                kind = "search";
                pattern = "^%?";
                icon = " ";
                lang = "regex";
              };
              filter = {
                pattern = "^:%s*!";
                icon = "$";
                lang = "bash";
              };
              lua = {
                pattern = "^:%s*lua%s+";
                icon = "";
                lang = "lua";
              };
              help = {
                pattern = "^:%s*he?l?p?%s+";
                icon = "";
              };
            };
          };

          messages = {
            enabled = true;
          };

          popupmenu = {
            enabled = true;
            backend = "nui";
          };

          notify = {
            enabled = false;
          };

          lsp = {
            progress = {
              enabled = false;
            };
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              "cmp.entry.get_documentation" = true;
            };
            hover = {
              enabled = true;
            };
            signature = {
              enabled = true;
            };
            message = {
              enabled = true;
            };
          };

          views = {
            cmdline_popup = {
              border = {
                style = "rounded";
                padding = [0 1];
              };
              position = {
                row = "50%";
                col = "50%";
              };
            };
            popupmenu = {
              border = {
                style = "rounded";
                padding = [0 1];
              };
            };
            hover = {
              border = {
                style = "rounded";
              };
            };
            signature = {
              border = {
                style = "rounded";
              };
            };
            confirm = {
              border = {
                style = "rounded";
              };
            };
          };

          routes = [
            {
              filter = {
                event = "msg_show";
                kind = "";
                find = "written";
              };
              opts = {skip = true;};
            }
          ];
        };
      };
    };
  };
}
