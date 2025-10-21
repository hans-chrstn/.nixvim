{lib, ...}: let
  components = import ./components {inherit lib;};
in {
  imports =
    [
      ./options.nix
      ./keymaps.nix
    ]
    ++ (lib.attrValues components);
  lsp.enable = true;
}
