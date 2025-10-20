{
  config,
  lib,
  ...
}:
let
  cfg = config.lsp;
in
{
  options.lsp = {
    enable = lib.mkEnableOption "Enable neovim LSP";
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      lsp-format.enable = false; # Will be using none-ls
      lsp = {
        enable = true;
        capabilities = "offsetEncoding = 'utf-16'";
        inlayHints = true;
        servers = {
          cssls = {
            enable = true;
          };
          html = {
            enable = true;
          };
          nixd = {
            enable = true;
            settings = {
              formatting = {
                enable = true;
                command = [ "alejandra" ];
              };
            };
          };
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
            settings = {
              checkOnSave = true;
              check = {
                command = "clippy";
              };
              procMacro.enable = true;
            };
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
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>cw" = {
              action = "workspace_symbol";
              desc = "Workspace Symbol";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "Code Action";
            };
            "<C-k>" = {
              action = "signature_help";
              desc = "Signature Help";
            };
          };
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "Line Diagnostics";
            };
            "[d" = {
              action = "goto_next";
              desc = "Next Diagnostic";
            };
            "]d" = {
              action = "goto_prev";
              desc = "Previous Diagnostic";
            };
          };
        };
        onAttach = ''
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(false)
              end
              vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
            end,
          })
        '';
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

      vim.diagnostic.config({
        float = { border = _border },
        virtual_text = {
          prefix = "",
        },
        signs = true,
        underline = true,
        update_in_insert = true,
      })

      require('lspconfig.ui.windows').default_options = {
        border = _border
      }

      config = function(_, opts)
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end
      end
    '';
  };
}
