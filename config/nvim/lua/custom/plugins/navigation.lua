return {
  -- An undo tree visualizer
  { "mbbill/undotree" },

  -- Visualize your marks
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        default_mappings = true,
        signs = true,
        mappings = {},
      })
    end,
  },

  -- Search the highlight word with RipGrep
  { "jremmen/vim-ripgrep" },

  { "nvim-tree/nvim-web-devicons" },

  -- File tree explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        renderer = {
          icons = {
            glyphs = {
              folder = {
                arrow_closed = ">",
                arrow_open = "",
              },
            },
          },
        },
      })
    end,
  },
  {
    "stevearc/aerial.nvim",
    opts = {},
    config = function()
      require("aerial").setup({
        layout = {
          width = 40,
          placement = "edge",
          default_direction = "right",
          resize_to_content = false,
        },
        attach_mode = "global",
      })
    end,
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
