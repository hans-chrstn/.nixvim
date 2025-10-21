{pkgs, ...}:
{
  vim = {
    globals = {
      gzip_plugin = 1;
      netrw_plugin = 1;
      tar_plugin = 1;
      tohtml_plugin = 1;
      tutor_plugin = 1;
      zip_plugin = 1;
      rplugin_plugin = 1;
      editorconfig_plugin = 1;
      matchparen_plugin = 1;
      matchit_plugin = 1;
      matchparen_timeout = 20;
      matchparen_insert_timeout = 20;
    };

    options = {
      termguicolors = true;
      number = true;
      relativenumber = true;
      numberwidth = 2;
      cursorline = false;
      cursorcolumn = false;
      clipboard = "unnamedplus";
      showmode = false;
      showmatch = true;
      matchtime = 2;
      winbar = "%=%m %F";
      conceallevel = 3;
      cmdheight = 0;
      laststatus = 3;
      showtabline = 0;
      list = true;
      smoothscroll = true;

      splitright = true;
      splitbelow = true;
      equalalways = true;

      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      inccommand = "nosplit";

      autoindent = true;
      expandtab = true;
      smarttab = true;
      smartindent = true;
      shiftround = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      formatoptions = "lcrnj";

      hidden = true;
      mouse = "a";
      mousescroll = "ver:2,hor:6";
      scrolloff = 3;
      sidescrolloff = 3;
      joinspaces = false;
      ttimeoutlen = 10;
      updatetime = 250;
      confirm = false;
      wildmode = "longest:full,full";
      autochdir = true;

      undofile = true;
      shada = "!,'50,<50,s10,h,r/tmp";

      foldenable = false;
      foldlevel = 99;
      foldlevelstart = 99;
      foldcolumn = "1";
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";

      virtualedit = "block";
      modelines = 5;
      modeline = true;
      modelineexpr = false;
      path = "**";
      grepprg = "rg --vimgrep --no-heading --smart-case";
      grepformat = "%f:%l:%c:%m,%f:%l:%m";
      formatprg = "prettier --stdin-filepath=%";
    };
  };
}
