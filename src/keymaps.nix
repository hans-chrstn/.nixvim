{ ... }:
{
  globals.mapleader = " ";

  keymaps = [
    {
      mode = "n";
      key = "<leader>d";
      action = "<cmd>lua vim.diagnostic.open_float(nil, { focus = false })<cr>";
      options.desc = "Open diagnostics float";
    }
  ];
}
