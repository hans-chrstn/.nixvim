{ ... }:
{
  vim.keymaps =
  [
    {
      mode = "n";
      key = "<leader>d";
      action = "<cmd>lua vim.diagnostic.open_float(nil, { focus = false })<cr>";
      desc = "Open diagnostics float";
    }
  ];
}
