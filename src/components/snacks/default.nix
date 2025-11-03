{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.snacks;
in {
  options.snacks = {
    enable = lib.mkEnableOption "Enable the snacks plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        bigfile = {
          enabled = true;
          notify = true;
          size = 1024 * 1024;
          setup = lib.mkLuaInline ''
            function(ctx)
              vim.b.minianimate_disable = true
              vim.schedule(function()
                vim.bo[ctx.buf].syntax = ctx.ft
              end)
            end
          '';
        };

        quickfile = {
          enabled = true;
        };

        words = {
          enabled = true;
          debounce = 100;
        };

        gitbrowse = {
          enabled = true;
          notify = true;
        };

        rename = {
          enabled = true;
        };

        bufdelete = {
          enabled = true;
        };

        input = {
          enabled = true;
        };

        zen = {
          enabled = true;
          toggles = {
            dim = true;
            git_signs = false;
            mini_diff_signs = false;
            diagnostics = false;
            inlay_hints = false;
          };
          zoom = {
            width = 120;
          };
        };

        statuscolumn = {
          enabled = true;
          left = ["mark" "sign"];
          right = ["fold" "git"];
          folds = {
            open = false;
            git_hl = false;
          };
          git = {
            patterns = ["GitSign" "MiniDiffSign"];
          };
        };

        dashboard = {
          enabled = true;

          preset = {
            header = ''
              ╔────────────────────────────────────────────────────────────────────╗
              │                                                                    │
              │  ███▄ ▄███▓ ▄▄▄      ▓█████▄ ▓█████  ██▓     ██▓ ███▄    █ ▓█████  │
              │ ▓██▒▀█▀ ██▒▒████▄    ▒██▀ ██▌▓█   ▀ ▓██▒    ▓██▒ ██ ▀█   █ ▓█   ▀  │
              │ ▓██    ▓██░▒██  ▀█▄  ░██   █▌▒███   ▒██░    ▒██▒▓██  ▀█ ██▒▒███    │
              │ ▒██    ▒██ ░██▄▄▄▄██ ░▓█▄   ▌▒▓█  ▄ ▒██░    ░██░▓██▒  ▐▌██▒▒▓█  ▄  │
              │ ▒██▒   ░██▒ ▓█   ▓██▒░▒████▓ ░▒████▒░██████▒░██░▒██░   ▓██░░▒████▒ │
              │ ░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒▒▓  ▒ ░░ ▒░ ░░ ▒░▓  ░░▓  ░ ▒░   ▒ ▒ ░░ ▒░ ░ │
              │ ░  ░      ░  ▒   ▒▒ ░ ░ ▒  ▒  ░ ░  ░░ ░ ▒  ░ ▒ ░░ ░░   ░ ▒░ ░ ░  ░ │
              │ ░      ░     ░   ▒    ░ ░  ░    ░     ░ ░    ▒ ░   ░   ░ ░    ░    │
              │        ░         ░  ░   ░       ░  ░    ░  ░ ░           ░    ░  ░ │
              │                       ░                                            │
              │                                                                    │
              ╚────────────────────────────────────────────────────────────────────╝
            '';
          };

          formats = {
            key = lib.mkLuaInline ''
              function(item)
                return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
              end
            '';
          };

          sections = [
            {section = "header";}
            {
              padding = 1;
              text = lib.mkLuaInline ''
                {
                  { "󰭎 ", hl = "SnacksDashboardIcon" },
                  { "[f] ", hl = "SnacksDashboardKey" },
                  { "Search  ", hl = "SnacksDashboardDesc" },
                  { "󰍉 ", hl = "SnacksDashboardIcon" },
                  { "[l] ", hl = "SnacksDashboardKey" },
                  { "Word Search  ", hl = "SnacksDashboardDesc" },
                  { " ", hl = "SnacksDashboardIcon" },
                  { "[o] ", hl = "SnacksDashboardKey" },
                  { "Recent Files  ", hl = "SnacksDashboardDesc" },
                  { " ", hl = "SnacksDashboardIcon" },
                  { "[n] ", hl = "SnacksDashboardKey" },
                  { "New File  ", hl = "SnacksDashboardDesc" },
                  { "󰩈 ", hl = "SnacksDashboardIcon" },
                  { "[q] ", hl = "SnacksDashboardKey" },
                  { " Exit", hl = "SnacksDashboardDesc" },
                }
              '';
              align = "center";
            }

            {
              hidden = true;
              key = "f";
              action = ":Telescope find_files";
            }
            {
              hidden = true;
              key = "l";
              action = ":Telescope live_grep";
            }
            {
              hidden = true;
              key = "o";
              action = ":Telescope oldfiles";
            }
            {
              hidden = true;
              key = "n";
              action = lib.mkLuaInline ''
                function()
                  local filename = vim.fn.input("Enter filename: ")
                  if filename ~= "" then
                    vim.cmd("edit " .. filename)
                  else
                    print("Filename cannot be empty")
                  end
                end
              '';
            }
            {
              hidden = true;
              key = "q";
              action = ":qa";
            }

            {
              icon = "";
              title = "Recently Used:";
              section = "recent_files";
              limit = 10;
              cwd = false;
              indent = 2;
              padding = 1;
            }

            {
              icon = "";
              title = "Projects:";
              section = "projects";
              limit = 8;
              indent = 2;
              padding = 1;
            }
          ];
        };

        notifier = {
          enabled = false;
          timeout = 3000;
          width = {
            min = 40;
            max = 0.4;
          };

          height = {
            min = 1;
            max = 0.6;
          };

          margin = {
            top = 0;
            right = 1;
            bottom = 0;
          };

          padding = true;
          sort = ["level" "added"];
          level = "trace";
          icons = {
            error = " ";
            warn = " ";
            info = " ";
            debug = " ";
            trace = " ";
          };

          style = "compact";
          top_down = true;
          date_format = "%R";
        };

        terminal = {
          enabled = false;
        };

        scroll = {
          enabled = false;
        };

        picker = {
          enabled = false;
        };

        indent = {
          enabled = false;
        };

        scope = {
          enabled = false;
        };

        scratch = {
          enabled = false;
        };

        animate = {
          enabled = false;
        };
      };
    };
    vim.keymaps = [
      {
        mode = "n";
        key = "<leader>z";
        action = "<cmd>lua Snacks.zen()<cr>";
        desc = "Toggle Zen Mode";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>lua Snacks.gitbrowse()<cr>";
        desc = "Open in GitHub/GitLab";
      }
      {
        mode = "n";
        key = "<leader>gB";
        action = "<cmd>lua Snacks.git.blame_line()<cr>";
        desc = "Git Blame Line";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua Snacks.rename.rename_file()<cr>";
        desc = "Rename File (LSP-aware)";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>lua Snacks.bufdelete()<cr>";
        desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>lua Snacks.bufdelete.all()<cr>";
        desc = "Delete All Buffers";
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>lua Snacks.bufdelete.other()<cr>";
        desc = "Delete Other Buffers";
      }
      {
        mode = "n";
        key = "]]";
        action = "<cmd>lua Snacks.words.jump(vim.v.count1)<cr>";
        desc = "Next Word Reference";
      }
      {
        mode = "n";
        key = "[[";
        action = "<cmd>lua Snacks.words.jump(-vim.v.count1)<cr>";
        desc = "Previous Word Reference";
      }
      {
        mode = "n";
        key = "<leader>lg";
        action = "<cmd>lua Snacks.lazygit()<cr>";
        desc = "LazyGit";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>lua Snacks.lazygit()<cr>";
        desc = "LazyGit";
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>lua Snacks.lazygit.log_file()<cr>";
        desc = "LazyGit Current File History";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>lua Snacks.lazygit.log()<cr>";
        desc = "LazyGit Log";
      }
    ];
  };
}
