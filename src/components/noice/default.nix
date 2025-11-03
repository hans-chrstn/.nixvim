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
          notify = {
            enabled = false;
          };
          messages = {
            enabled = true;
          };
          lsp = {
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              "cmp.entry.get_documentation" = true;
            };
            message = {
              enabled = true;
            };
            progress = {
              enabled = false;
              view = "mini";
            };
          };
          popupmenu = {
            enabled = true;
            backend = "nui";
          };
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
          };
          routes = [
            {
              filter = {
                event = "notify";
              };
              view = "notify";
            }
          ];
          format = {
            filter = {
              pattern = [
                ":%s*%%s*s:%s*"
                ":%s*%%s*s!%s*"
                ":%s*%%s*s/%s*"
                "%s*s:%s*"
                ":%s*s!%s*"
                ":%s*s/%s*"
              ];
              icon = "";
              lang = "regex";
            };
            replace = {
              pattern = [
                ":%s*%%s*s:%w*:%s*"
                ":%s*%%s*s!%w*!%s*"
                ":%s*%%s*s/%w*/%s*"
                "%s*s:%w*:%s*"
                ":%s*s!%w*!%s*"
                ":%s*s/%w*/%s*"
              ];
              icon = "󱞪";
              lang = "regex";
            };
          };
        };
      };
    };
  };
}
