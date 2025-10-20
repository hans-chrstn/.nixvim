{ lib, config, pkgs, ... }:

let
  cfg = config.lazy-lsp;
in
{
  options.lazy-lsp = {
    enable = lib.mkEnableOption "Enable the lazy-lsp plugin";
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = with pkgs.vimPlugins; [ lazy-lsp-nvim ];
    extraConfigLua = ''
      require("lazy-lsp").setup {
        use_vim_lsp_config = true,
        preferred_servers = {
          markdown = {},
          python = { "basedpyright", "ruff" },
          rust = { "rust_analyzer" },
        },
      }
    '';
  };
}
