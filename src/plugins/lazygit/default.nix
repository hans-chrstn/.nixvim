{
  lib,
  config,
  ...
}: let
  cfg = config.lazygit;
in {
  options.lazygit = {
    enable = lib.mkEnableOption "Enable the lazygit plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins.lazygit = {
      enable = true;
    };

    extraConfigLua = ''
      require("telescope").load_extension("lazygit")
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {
          desc = "LazyGit (root dir)";
        };
      }
    ];  };
}
