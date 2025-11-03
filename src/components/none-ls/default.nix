{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.none-ls;
in {
  options.none-ls = {
    enable = lib.mkEnableOption "Enable the none-ls plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.lazy.plugins = {
      "none-ls.nvim" = {
        package = pkgs.vimPlugins.none-ls-nvim;
        setupModule = "none-ls";
        setupOpts = {
          enableLspFormat = false;
          updateInInsert = false;
          onAttach = lib.mkLuaInline ''
            function(client, bufnr)
                if client.supports_method "textDocument/formatting" then
                  vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                  vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                      vim.lsp.buf.format { bufnr = bufnr }
                    end,
                  })
                end
              end
          '';
          sources = {
            code_actions = {
              gitsigns.enable = true;
              statix.enable = true;
            };

            diagnostics = {
              checkstyle.enable = true;
              statix.enable = true;
            };

            formatting = {};
          };
        };

        lazy = true;
      };
    };
  };
}
