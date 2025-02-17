return {

  -- make vim repeat plugin work with surround
  { "tpope/vim-repeat" },

  -- surround text objects
  { "tpope/vim-surround" },

  -- like runtime matchit only better - matches parens, brackets, etc
  { "andymass/vim-matchup" },

  -- provide ]q ]e etc - basically anything where things go back and forth
  { "tpope/vim-unimpaired" },

  -- Yank Ring
  {
    "gbprod/yanky.nvim",
    opts = {},
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = {"n", "x"} },
      { "P", "<Plug>(YankyPutBefore)", mode = {"n", "x"} },
      { "gp", "<Plug>(YankyGPutAfter)", mode = {"n", "x"} },
      { "gP", "<Plug>(YankyGPutBefore)", mode = {"n", "x"} },
      { "~p", "<Plug>(YankyPreviousEntry)", mode = {"n" } },
      { "~P", "<Plug>(YankyNextEntry)", mode = {"n" } },
    }
  },

  {
    "fzf_yankring",
    dependencies = { "ibhagwan/fzf-lua", "gbprod/yanky.nvim" },
    dev = true,
    opts = {},
    keys = {
      { ",y", ":lua require('fzf_yankring').yanks()<CR>", mode = {"n"}, desc = "Show Yank History" },
    }

  },

  -- Close everything but the current buffer
  { "duff/vim-bufonly" },

  -- It's basically an inflector
  { "tpope/vim-abolish" },

  -- Tabularize
  { "godlygeek/tabular" },

  -- Commenting
  { "tpope/vim-commentary" },

  -- Use <C-a> and <C-x> to increment/decrement dates
  { "tpope/vim-speeddating" },

  -- Swap treesitter nodes
  { "mizlan/iswap.nvim" },

  -- Custom operator definition in Lua
  { "zdcthomas/yop.nvim" },
}
