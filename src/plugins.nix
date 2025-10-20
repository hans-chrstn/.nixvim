{
  pkgs,
  lib,
  ...
}: let
  plugins = import ./plugins {inherit lib;};
in {
  imports = lib.attrValues plugins;
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
