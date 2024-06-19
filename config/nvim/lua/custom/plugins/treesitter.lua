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
          prev_selection = ",",
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
          },
        },
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.jinja2 = {
        install_info = {
          url = "/Users/stephenprater/src/gihub.com/dbt-labs/tree-sitter-jinja2",
          files = { "src/parser.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "jinja2",
      }

      parser_config.tree_sitter_query = {
        install_info = {
          url = "https://github.com/tree-sitter-grammars/tree-sitter-query",
          files = { "src/parser.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "query",
      }
      vim.keymap.set("n", "<leader>q", "<cmd>TSPlaygroundToggle<cr>")
    end,
  },
  { "RRethy/nvim-treesitter-textsubjects", dependencies = "nvim-treesitter/nvim-treesitter" },
  { "RRethy/nvim-treesitter-endwise",      dependencies = "nvim-treesitter/nvim-treesitter" },
  { "nvim-treesitter/playground",          dependencies = "nvim-treesitter/nvim-treesitter" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local rainbow_delimters = require("rainbow-delimiters")

      vim.g.rainbow_delimters = {
        strategy = {
          [""] = rainbow_delimters.strategy["global"],
        },
      }
    end,
  },
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("treesj").setup()
    end,
  },
}
