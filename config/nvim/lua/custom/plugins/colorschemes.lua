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
    priority = 1000,
	},

  -- A color picker
  {
    'ziontee113/color-picker.nvim',
    lazy = true,
    cmd = {
      "PickColorNormal",
      "PickColorInsert",
    },
    opts = {
      border = "rounded",
    },
    keys = {
      { "<C-c>", "<cmd>PickColorInsert<CR>", mode = {"i"}, desc = "Pick Color"  },
      { "<C-c>", "<cmd>PickColorNormal<CR>", mode = {"n"}, desc = "Pick Color"  },
    }
  },
}

