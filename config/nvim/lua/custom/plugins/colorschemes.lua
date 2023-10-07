return {
  -- Ye Olde Nord
  'arcticicestudio/nord-vim',

  -- Modernized nord
  {
     'rmehri01/onenord.nvim',
     lazy = true,
  },

	{
		"rebelot/kanagawa.nvim",
		lazy = true
	},

  -- A color picker
  {
    'ziontee113/color-picker.nvim',
    config = function()
      require("color-picker").setup({
        border = "rounded"
      })

      vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-c>", "<cmd>PickColorInsert<CR>", { noremap = true, silent = true })
    end,
  },
}

