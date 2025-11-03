{
  lib,
  pkgs,
  ...
}: let
  components = import ./components {inherit lib;};
in {
  vim.extraPackages = with pkgs; [
    xclip
    xsel
    wl-clipboard
    ripgrep
    fd
    nodejs
    black
    prettier
    stylua
    rustfmt
    google-java-format
  ];
  imports =
    [
      ./options.nix
      ./keymaps.nix
    ]
    ++ (lib.attrValues components);
  lsp.enable = true;
  autopairs.enable = true;
  barbar.enable = true;
  cmp.enable = true;
  web-devicons.enable = true;
  comment.enable = true;
  conform.enable = true;
  copilot.enable = true;
  cord.enable = true;
  # dashboard.enable = true;
  fidget.enable = true;
  gitsigns.enable = true;
  lspsaga.enable = true;
  lualine.enable = true;
  noice.enable = true;
  none-ls.enable = true;
  notify.enable = true;
  render-markdown.enable = true;
  telescope.enable = true;
  todo-comments.enable = true;
  toggleterm.enable = true;
  treesitter.enable = true;
  trouble.enable = true;
  which-key.enable = true;
  yazi.enable = true;
  cinnamon.enable = true;
  smear-cursor.enable = true;
  colorizer.enable = true;
  snacks.enable = true;
}
