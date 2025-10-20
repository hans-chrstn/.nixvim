{ lib, config, ... }:

let
  cfg = config.comment;
in
{
  options.comment = {
    enable = lib.mkEnableOption "Enable the comment plugin";
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      comment.enable = true;
    };
    extraConfigLua = ''
      require('Comment').setup({
        padding = true,
        sticky = true,
        ignore = nil,
        togler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gca',
          below = 'gcb',
          eol = 'gce',
        },

        mappings = {
          basic = true,
          extra = true,
        },

        pre_hook = nil,
        post_hook = nil,
      })
    '';
  };
}
