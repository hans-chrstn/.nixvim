{ pkgs, lib, ...}:
let
  plugins = import ./plugins { inherit lib; };
in 
{
  imports = lib.attrValues plugins;
  colorschemes = {
    oxocarbon.enable = true;
  };
  lsp.enable = true;
  barbar.enable = true;
  comment.enable = true;
  cord.enable = true;
}
