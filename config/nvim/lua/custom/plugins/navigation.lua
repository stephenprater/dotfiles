return {
  -- An undo tree visualizer
  { "mbbill/undotree" },

  -- Visualize your marks
  { "chentoast/marks.nvim" },

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
}
