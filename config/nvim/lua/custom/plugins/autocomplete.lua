return {
  {
    "L3MON4D3/LuaSnip",
    tag = "v2.2.0",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip/loaders/from_vscode").lazy_load()
      require("luasnip/loaders/from_vscode").lazy_load({
        paths = vim.fn.stdpath("config") .. "/snippets",
      })

      luasnip.setup({
        store_selection_keys = "s",
      })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      { "olimorris/codecompanion.nvim" },
    },
    lazy = true,
    version= "v0.*",
    event = "InsertEnter",
    opts = {
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
        cmdline = {}
      },
      signature = {
        enabled = true,
      },
      keymap = {
        ["Down"] = { "select_next", "fallback" },
        ["Up"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-e>"] = { "show_documentation", "hide_documentation", "hide", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<C-n>"] = {
          "select_next",
          "fallback"
        },
        ["<C-p>"] = {
          "select_prev",
          "fallback"
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
