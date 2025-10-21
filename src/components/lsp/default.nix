{
  lib,
  config,
  ...
}: let
  cfg = config.lsp;
in {
  options.lsp = {
    enable = lib.mkEnableOption "Enable the lsp-config plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.lsp = {
        enable = true;
        inlayHints.enable = true;
        lightbulb = {
          enable = true;
        };
      };
      vim.languages = {
        enableTreesitter = true;

        nix = {
          enable = true;
          format.enable = true;
          lsp = {
            enable = true;
            server = "nixd";
          };
        };
        ts.enable = true;
        rust.enable = true;
        html.enable = true;
        css.enable = true;
        tailwind.enable = true;
        yaml.enable = true;
        go.enable = true;
        lua.enable = true;
        php.enable = true;
        svelte.enable = true;
        python.enable = true;
        bash.enable = true;
        clang.enable = true;
        csharp.enable = true;
        markdown.enable = true;
      };

      vim.keymaps = [
        {
          silent = true;
        }
      ];
    };
}
