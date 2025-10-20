{
  pkgs,
  lib,
  ...
}: let
  plugins = import ./plugins {inherit lib;};
in {
  imports = lib.attrValues plugins;
  colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        background = {
          light = "macchiato";
          dark = "mocha";
        };
        flavour = "mocha";
        disable_bold = false;
        disable_italic = false;
        disable_underline = false;
        transparent_background = true;
        term_colors = true;
        integrations = {
          cmp = true;
          noice = true;
          notify = true;
          gitsigns = true;
          # which_key = true;
          # illuminate.enabled = true;
          treesitter = true;
          treesitter_context = true;
          telescope.enabled = true;
          indent_blankline.enabled = true;
          mini.enabled = false;
          native_lsp = {
            enabled = true;
            inlay_hints = {
              background = true;
            };
            underlines = {
              errors = ["underline"];
              hints = ["underline"];
              information = ["underline"];
              warnings = ["underline"];
            };
          };
        };
      };
    };
  };
  lsp.enable = true;
  barbar.enable = true;
  comment.enable = true;
  cord.enable = true;
  lazy-lsp.enable = true;
  none-ls.enable = true;
  lspsaga.enable = true;
  trouble.enable = true;
  fidget.enable = true;
  conform.enable = true;
  autopairs.enable = true;
  dashboard.enable = true;
  lualine.enable = true;
  cmp.enable = true;
  copilot.enable = true;
  render-markdown.enable = true;
  telescope.enable = true;
  todo-comments.enable = true;
  toggleterm.enable = true;
  treesitter.enable = true;
  yazi.enable = true;
  notify.enable = true;
  noice.enable = true;
  gitsigns.enable = true;
  lazygit.enable = true;
  which-key.enable = true;
}
