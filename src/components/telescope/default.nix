{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.telescope;
in {
  options.telescope = {
    enable = lib.mkEnableOption "Enable the telescope plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.telescope = {
      enable = true;
      extensions = [
        {
          name = "fzf";
          packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
          setup = {
            fzf = {
              fuzzy = true;
              override_generic_sorter = true;
              override_file_sorter = true;
              case_mode = "smart_case";
            };
          };
        }
        {
          name = "ui-select";
          packages = [pkgs.vimPlugins.telescope-ui-select-nvim];
          setup = {
            ui-select = {
              specific_opts = {
                codeactions = true;
              };
            };
          };
        }
        {
          name = "media-files";
          packages = [pkgs.vimPlugins.telescope-media-files-nvim];
          setup = {
            media_files = {
              filetypes = ["png" "jpg" "mp4" "webm" "gif" "pdf"];
              find_cmd = "rg";
            };
          };
        }
      ];
      setupOpts = {
        defaults = {
          mappings = {
            i = {
              "<esc>" = {
                _type = "lua-inline";
                expr = ''
                  function(...)
                    return require('telescope.actions').close(...)
                  end
                '';
              };
            };
          };
        };
        pickers = {
          colorscheme = {enable_preview = true;};
          find_files = {
            hidden = true;
            ignored = true;
          };
        };
      };

      mappings = {
        findFiles = "<leader>ff";
        liveGrep = "<leader>/";
        buffers = "<leader>fb";
        resume = "<leader>fr";
        gitCommits = "<leader>gc";
        gitStatus = "<leader>gs";
        helpTags = "<leader>sh";
        findProjects = "<leader>fp";
      };
    };

    vim.keymaps = [
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>Telescope find_files<cr>";
        desc = "Find project files";
      }
      {
        mode = "n";
        key = "<leader>:";
        action = "<cmd>Telescope command_history<cr>";
        desc = "Command History";
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>Telescope buffers<cr>";
        desc = "+buffer";
      }
      {
        mode = "n";
        key = "<C-p>";
        action = "<cmd>Telescope git_files<cr>";
        desc = "Search git files";
      }
      {
        mode = "n";
        key = "<leader>sa";
        action = "<cmd>Telescope autocommands<cr>";
        desc = "Auto Commands";
      }
      {
        mode = "n";
        key = "<leader>sb";
        action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
        desc = "Buffer";
      }
      {
        mode = "n";
        key = "<leader>sc";
        action = "<cmd>Telescope command_history<cr>";
        desc = "Command History";
      }
      {
        mode = "n";
        key = "<leader>sC";
        action = "<cmd>Telescope commands<cr>";
        desc = "Commands";
      }
      {
        mode = "n";
        key = "<leader>sD";
        action = "<cmd>Telescope diagnostics<cr>";
        desc = "Workspace diagnostics";
      }
      {
        mode = "n";
        key = "<leader>sH";
        action = "<cmd>Telescope highlights<cr>";
        desc = "Search Highlight Groups";
      }
      {
        mode = "n";
        key = "<leader>sk";
        action = "<cmd>Telescope keymaps<cr>";
        desc = "Keymaps";
      }
      {
        mode = "n";
        key = "<leader>sM";
        action = "<cmd>Telescope man_pages<cr>";
        desc = "Man pages";
      }
      {
        mode = "n";
        key = "<leader>sm";
        action = "<cmd>Telescope marks<cr>";
        desc = "Jump to Mark";
      }
      {
        mode = "n";
        key = "<leader>so";
        action = "<cmd>Telescope vim_options<cr>";
        desc = "Options";
      }
      {
        mode = "n";
        key = "<leader>sR";
        action = "<cmd>Telescope resume<cr>";
        desc = "Resume";
      }
      {
        mode = "n";
        key = "<leader>uC";
        action = "<cmd>Telescope colorscheme<cr>";
        desc = "Colorscheme preview";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>Telescope diagnostics bufnr=0<cr>";
        desc = "Document Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>st";
        action = "<cmd>Telescope todo-comments<cr>";
        desc = "Todo (Telescope)";
      }
    ];
  };
}
