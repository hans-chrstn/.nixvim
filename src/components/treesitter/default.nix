{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.treesitter;
in {
  options.treesitter = {
    enable = lib.mkEnableOption "Enable the treesitter plugin";
  };

  config = lib.mkIf cfg.enable {
    vim.treesitter = {
      enable = true;
      autotagHtml = true;
      context = {
        enable = true;
      };
      fold = true;
      highlight = {
        enable = true;
        additionalVimRegexHighlighting = true;
      };
      indent.enable = true;

      incrementalSelection.enable = true;

      textobjects = {
        enable = true;
        setupOpts = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = "@class.inner";
              "ii" = "@conditional.inner";
              "ai" = "@conditional.outer";
              "il" = "@loop.inner";
              "al" = "@loop.outer";
              "at" = "@comment.outer";
            };
          };
          move = {
            enable = true;
            gotoNextStart = {
              "]m" = "@function.outer";
              "]]" = "@class.outer";
            };
            gotoNextEnd = {
              "]M" = "@function.outer";
              "][" = "@class.outer";
            };
            gotoPreviousStart = {
              "[m" = "@function.outer";
              "[[" = "@class.outer";
            };
            gotoPreviousEnd = {
              "[M" = "@function.outer";
              "[]" = "@class.outer";
            };
          };
          swap = {
            enable = true;
            swapNext = {
              "<leader>a" = "@parameters.inner";
            };
            swapPrevious = {
              "<leader>A" = "@parameter.outer";
            };
          };
        };
      };

      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        html
        css
        javascript
        jsdoc
        json
        lua
        luadoc
        luap
        nix
        rust
        java
        markdown
        markdown-inline
        python
        query
        regex
        tsx
        typescript
        vim
        vimdoc
        toml
        yaml
      ];
    };

    vim.treesitter.mappings.incrementalSelection = {
      init = "<C-space>";
      incrementByNode = "<C-space>";
      decrementByNode = "<bs>";
      incrementByScope = null;
    };

    vim.lazy.plugins = {
      "nvim-ts-context-commentstring" = {
        package = pkgs.vimPlugins.nvim-ts-context-commentstring;
        event = ["BufWinEnter"];
      };
    };
  };
}
