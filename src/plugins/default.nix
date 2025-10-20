{ lib }:
let
  dirContents = builtins.readDir ./.;
  pluginDirs = lib.filterAttrs (name: type: type == "directory") dirContents;
in
lib.mapAttrs (name: _: import ./${name}) pluginDirs
