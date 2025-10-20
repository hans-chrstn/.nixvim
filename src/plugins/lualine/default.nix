{
  lib,
  config,
  ...
}: let
  cfg = config.lualine;
in {
  options.lualine = {
    enable = lib.mkEnableOption "Enable the lualine plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins.lualine = {
      enable = true;
      settings = {
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = [];
        };
      };
    };
    extraConfigLua = ''
      local symbols = {}
      if trouble then
        symbols = trouble.statusline({
          mode = "lsp_document_symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
      end
    '';
  };
}
