{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  name = "lazy-lsp";
  src = fetchFromGitHub {
    owner = "dundalek";
    repo = "lazy-lsp.nvim";
    rev = "ccaaed19d7963bdc06000052eade993452b7ad86";
    hash = "sha256-FRfszo6jYEFRfxRSYuYry9vJi0QtX3Dd4XXpOOF0x4E=";
  };

  nvimSkipModules = ["lazy-lsp.overrides"];
}
