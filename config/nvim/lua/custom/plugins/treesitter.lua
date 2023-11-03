return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "ruby", "typescript", "vim", "go", "norg" },
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},

				endwise = {
					enable = true,
				},

				matchup = {
					enable = true,
				},

				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { "BufWrite", "CursorHold" },
				},

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},

				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
						},
					},
				},

				playground = {
					enabled = true,
					updatetime = 25,
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "h",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},

				textsubjects = {
					enable = true,
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
					},
				},
			})
		end,
	},
	{
		"ziontee113/syntax-tree-surfer",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local sts = require("syntax-tree-surfer")
			local sts_opts = { noremap = true, silent = true }

			-- Swapping Nodes in Visual Mode
			vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", sts_opts)
			vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", sts_opts)
			vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", sts_opts)
			vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", sts_opts)
			vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<cr>", sts_opts)
			vim.keymap.set("x", "L", "<cmd>STSSelectChildNode<cr>", sts_opts)
			vim.keymap.set("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", sts_opts)
			vim.keymap.set("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", sts_opts)

			vim.keymap.set("n", "gt", function()
				sts.targeted_jump({
          "module",
          "class",
          "method",
          "if",
          "do_block",
          "block",
          "function",
          "object",
          "arguments",
          "property",
          "name",
        })
			end)
		end,
	},
	{ "RRethy/nvim-treesitter-textsubjects", dependencies = "nvim-treesitter/nvim-treesitter" },
	{ "RRethy/nvim-treesitter-endwise", dependencies = "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/playground", dependencies = "nvim-treesitter/nvim-treesitter" },
	{
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local rainbow_delimters = require("rainbow-delimiters")

      vim.g.rainbow_delimters = {
        strategy = {
          [''] = rainbow_delimters.strategy['global']
        }
      }
    end
  },
  {
    "Wansmer/treesj",
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = "nvim-treesitter/nvim-treesitter" ,
    config = function ()
      require('treesj').setup()
    end
  },
}
