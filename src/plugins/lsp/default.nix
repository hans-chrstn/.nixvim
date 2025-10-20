{ config, lib, ... }:
let
  cfg = config.lsp;
in 
{
  options.lsp = {
    enable = lib.mkEnableOption "Enable neovim LSP";
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      lsp-format.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          cssls = { enable = true; };
          html = { enable = true; };
          yamlls = {
            enable = true;
            settings = {
              schemaStore = {
                enable = false;
                url = "";
              };
            };
          };

          gopls = {
            enable = true;
            autostart = true;
          };

          lua_ls = {
            enable = true;
            settings.telemetry.enable = false;
          };

          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };

          harper_ls = {
            enable = true;
            settings.settings = {
              "harper-ls" = {
                linters = {
                  boring_words = true;
                  linking_verbs = true;
                  sentence_capitalization = false;
                  spell_check = false;
                };
                codeActions = {
                  forceStable = true;
                };
              };
            };
          };

          ts_ls.enable = true;
          tailwindcss.enable = true;
          phpactor.enable = true;
          svelte.enable = false;
          pyright.enable = true;
          dockerls.enable = true;
          bashls.enable = true;
          clangd.enable = true;
          csharp_ls.enable = true;
          markdown_oxide.enable = true;
        };

        keymaps = {
          silent = true;
          lspBuf = {
            gd = {
              action = "definition";
              desc = "Goto Definition";
            };
            gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "Type Definition";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
          };
        };
      };
    };

    extraConfigLua = ''
      local _border = "rounded"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = _border
        }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = _border
        }
      )

      vim.diagnostic.config{
        float={border=_border}
      };

      require('lspconfig.ui.windows').default_options = {
        border = _border
      }

      config = function(_, opts)
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
          -- passing config.capabilities to blink.cmp merges with the capabilities in your
          -- `opts[server].capabilities, if you've defined it
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end
      end;
    '';
  };
}
