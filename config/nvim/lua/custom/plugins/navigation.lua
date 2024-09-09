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
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
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
  {
    "rgroli/other.nvim",
    config = function()
      require("other-nvim").setup({
        rememberBuffers = false,
        style = {
          border = "single",
          seperator = "│",
        },
        mappings = {
          {
            -- {repo}/{application}/{module}/{role}.py
            pattern = "(commercial_ai)/(.*)/(.*)/(.*).py$",
            target = {
              {
                target = "%1/%2/%3/models.py",
                context = "model",
              },
              {
                target = "%1/%2/%3/queries.py",
                context = "query",
              },
              {
                target = "%1/%2/%3/router.py",
                context = "router",
              },
              {
                target = "%1/%2/%3/struct.py",
                context = "struct",
              },
              {
                target = "%1/%2/%3/templates.py",
                context = "template",
              },
              {
                target = "%1/%2/%3/__init__.py",
                context = "module",
              },
              {
                target = "%1/%2/%3/sql/*.sql",
                context = "sql",
              },
              {
                target = "tests/%2/%3/test_%4.py",
                context = "test",
              },
            },
          },
          {
            pattern = "(commercial_ai)/(.*)/(.*)/sql/*.sql$",
            target = "%1/%2/%3/queries.py",
            context = "query",
          },
          {
            pattern = "tests/(.*)/(.*)/test_(.*).py$",
            target = "commercial_ai/%1/%2/%3.py",
            context = "subject",
          },
        },
      })
    end,
  },
}
