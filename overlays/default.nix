final: prev: {
  vimPlugins =
    prev.vimPlugins
    // (
      import ../packages {
        pkgs = final;
        lib = final.lib;
      }
    );
}
