return {
  {
    "Shopify/spin-vim",
    lazy = true,
    cond = function()
      if os.getenv("SPIN") == "1" then
        return true
      else
        return false
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    lazy = true,
    event = "BufAdd */*test*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "zidhuss/neotest-minitest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
      "jfpedroza/neotest-elixir",
    },
    config = function()
      require("neotest").setup({
        discovery = {
          enabled = false,
        },
        log_level = vim.log.levels.DEBUG,
        adapters = {
          require("neotest-minitest"),
          require("neotest-vitest"),
          require("neotest-elixir"),
          require("neotest-python")({
            args = { "-vv" },
          }),
        },
      })
    end,
  },
  {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_install_global = 0
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  },
  {
    "dmmulroy/tsc.nvim",
    config = function()
      require("tsc").setup()
    end,
  },
  { "jgdavey/tslime.vim" },
  {
    "vim-test/vim-test",
    dependencies = {
      "jgdavey/tslime.vim",
    },
    config = function()
      vim.cmd([[
        let test#strategy = "tslime"
      ]])
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      local keys = {
        ["tab"] = vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
        ["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
        ["ctrl-tab"] = vim.api.nvim_replace_termcodes("<C-Tab>", true, true, true),
        ["esc"] = vim.api.nvim_replace_termcodes("<Esc>", true, true, true),
      }

      vim.keymap.set("i", "<Tab>", function()
        if vim.fn.pumvisible() ~= 0 then
          return keys["ctrl-y"]
        elseif require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
          return
        else
          return keys["tab"]
        end
      end, { expr = true })

      vim.keymap.set("i", "<Esc>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").dismiss()
          return
        else
          return keys["esc"]
        end
      end, { expr = true })

      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
        },
      })
    end,
  },
  {
    "yetone/avante.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    config = function()
      local openai = require("avante.providers.openai")

      require("avante").setup({
        -- @type AvanteProvider
        provider = "shopify-ai",
        vendors = {
          ["shopify-ai"] = {
            endpoint = "https://proxy.shopify.ai/v3/v1",
            model = "anthropic:claude-3-5-sonnet",
            api_key_name = "cmd:openai_key cat",
            parse_curl_args = openai.parse_curl_args,
            parse_response_data = openai.parse_response,
          },
        },
      })
    end,
  },
}
