{
  lib,
  config,
  ...
}: let
  cfg = config.cmp;
in {
  options.cmp = {
    enable = lib.mkEnableOption "Enable the cmp plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      cmp-async-path = { enable = true; };
      cmp-latex-symbols = { enable = true; };
      cmp-nvim-lsp = { enable = true; };
      cmp-buffer = { enable = true; };
      cmp-cmdline = { enable = true; };
      cmp_luasnip = { enable = true; };
      cmp-git = { enable = true; };
      friendly-snippets = { enable = true; };
      cmp = {
        enable = true;
        autoEnableSources = false;
        settings = {
          experimental = { ghost_text = true; };
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          window = {
            completion = {
              border = "rounded";
              winHighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
            };
            documentation = { border = "rounded"; };
          };
          mapping = {
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";

            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<C-e>" = "cmp.mapping.abort()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" =
              "cmp.mapping.confirm({ select = false })";
            "<S-CR>" =
              "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "async_path"; }
            {
              name = "buffer";
              keyword_length = 5;
            }
            { name = "copilot"; }
            {
              name = "luasnip";
              keyword_length = 3;
            }
            {
              name = "latex_symbols";
              option = {
                strategy = 0;
              };
            }
          ];

          formatting = {
            fields = [ "kind" "abbr" "menu" ];
            expandable_indicator = true;
          };
          performance = {
            debounce = 60;
            fetching_timeout = 200;
            max_view_entries = 30;
          };
        };
      };
    };
    extraConfigLua = ''
      luasnip = require("luasnip")
      kind_icons = {
        Text = "󰊄",
        Method = "",
        Function = "󰡱",
        Constructor = "",
        Field = "",
        Variable = "󱀍",
        Class = "",
        Interface = "",
        Module = "󰕳",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }

      local cmp = require'cmp'

      cmp.setup.cmdline({'/', "?" }, {
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' },
        }, {
        { name = 'buffer' },
        })
      })

      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
        { name = 'cmdline' }
        }),
      })
    '';
  };
}
