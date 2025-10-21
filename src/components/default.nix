{ lib }:
let
  dirContents = builtins.readDir ./.;
  componentDirs = lib.filterAttrs (name: type: type == "directory") dirContents;
in
lib.mapAttrs (name: _: import ./${name}) componentDirs
