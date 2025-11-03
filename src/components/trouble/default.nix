{
  lib,
  config,
  ...
}: let
  cfg = config.trouble;
in {
  options.trouble = {
    enable = lib.mkEnableOption "Enable the trouble plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.lsp.trouble = {
      enable = true;
      setupOpts = {
        auto_close = true;
      };
      mappings = {
        workspaceDiagnostics = "<leader>xx";
        documentDiagnostics = "<leader>xX";
        quickfix = "<leader>xQ";
      };
    };
    vim.keymaps = [
      {
        mode = "n";
        key = "<leader>x";
        action = "+diagnostics/quickfix";
        desc = "+diagnostics/quickfix";
      }
      {
        mode = "n";
        key = "<leader>xt";
        action = "<cmd>Trouble todo<cr>";
        silent = true;
        desc = "Todo (Trouble)";
      }
    ];
  };
}
