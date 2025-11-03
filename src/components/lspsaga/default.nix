{
  lib,
  config,
  ...
}: let
  cfg = config.lspsaga;
in {
  options.lspsaga = {
    enable = lib.mkEnableOption "Enable the lspsaga plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.lsp.lspsaga = {
      enable = true;
      setupOpts = {
        beacon.enable = true;
        ui = {
          border = "rounded";
          codeAction = "💡";
        };
        hover = {
          openCmd = "!zen";
          openLink = "gx";
        };
        diagnostic = {
          borderFollow = true;
          diagnosticOnlyCurrent = false;
          showCodeAction = true;
        };
        symbolInWinbar = {
          enable = true;
        };
        codeAction = {
          extendGitSigns = false;
          showServerName = true;
          onlyInCursor = true;
          numShortcut = true;
          keys = {
            exec = "<CR>";
            quit = [
              "<Esc>"
              "q"
            ];
          };
        };
        lightbulb = {
          enable = false;
          sign = false;
          virtualText = true;
        };
        implement = {
          enable = false;
        };
        rename = {
          autoSave = false;
          keys = {
            exec = "<CR>";
            quit = [
              "<C-k>"
              "<Esc>"
            ];
            select = "x";
          };
        };
        outline = {
          autoClose = true;
          autoPreview = true;
          closeAfterJump = true;
          layout = "normal";
          winPosition = "right";
          keys = {
            jump = "e";
            quit = "q";
            toggleOrJump = "o";
          };
        };
        scrollPreview = {
          scrollDown = "<C-f>";
          scrollUp = "<C-b>";
        };
      };
    };
  };
}
