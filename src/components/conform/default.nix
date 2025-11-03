{
  lib,
  config,
  ...
}: let
  cfg = config.conform;
in {
  options.conform = {
    enable = lib.mkEnableOption "Enable the conform plugin";
  };

  config =
    lib.mkIf cfg.enable {
      vim.formatter.conform-nvim = {
        enable = true;
        setupOpts = {
          format_on_save = lib.mkLuaInline ''
            function(bufnr)
              -- Disable with a global or buffer-local variable
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              return { timeout_ms = 500, lsp_format = 'fallback' }
            end
          '';
          formatters_by_ft = {
            html = [ "prettier" ];
            css = ["prettier"];
            javascript = ["prettier"];
            typescript = ["prettier"];
            typescriptreact = ["prettier"];
            java = ["google-java-format"];
            python = ["black"];
            lua = ["stylua"];
            nix = ["alejandra"];
            markdown = ["prettier"];
            rust = ["rustfmt"];
          };
        };
      };

      vim.keymaps = [
        {
          mode = "n";
          key = "<leader>uf";
          action = ":FormatToggle<CR>";
          desc = "Toggle Format Globally";
          silent = true;
        }
        {
          mode = "n";
          key = "<leader>uF";
          action = ":FormatToggle!<CR>";
          desc = "Toggle Format Locally";
          silent = true;
        }
        {
          mode = "n";
          key = "<leader>cf";
          action = "<cmd>lua require('conform').format()<cr>";
          silent = true;
          desc = "Format Buffer";
        }

        {
          mode = "v";
          key = "<leader>cF";
          action = "<cmd>lua require('conform').format()<cr>";
          silent = true;
          desc = "Format Lines";
        }
      ];
    };
}
