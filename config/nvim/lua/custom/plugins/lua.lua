return {
  { 'folke/neodev.nvim' },
  { 'nvim-lua/plenary.nvim' },
  { 'bfredl/nvim-luadev',
    cmd = "Luadev" ,
    keys = {
      { mode = "n", "<leader>ll", "<Plug>(Luadev-RunLine)",     { silent = true, desc = "Execute the current line" }, },
      { mode = "n", "<leader>la", "<Plug>(Luadev-Run)",         { silent = true, desc = "Operator to execute lua code over a movement or text object." }, },
      { mode = "n", "<leader>le", "<Plug>(Luadev-RunWord)",     { silent = true, desc = "Eval identifier under cursor, including table.attr" }, },
    },
  },
  { 'jbyuki/one-small-step-for-vimkind' }
}
