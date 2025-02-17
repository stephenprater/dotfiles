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
    "yochem/jq-playground.nvim",
    opts = {
      cmd = { "jq" }
    }
  },
  {
    "nvim-neotest/neotest",
    lazy = true,
    event = "BufAdd */*test*",
    dependencies = {
      "nvim-neotest/neotest-plenary",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      { dir = "~/src/github.com/zidhuss/neotest-minitest" },
      -- "zidhuss/neotest-minitest",
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
          require("neotest-plenary"),
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
  -- {
  --   "mattn/emmet-vim",
  --   config = function()
  --     vim.g.user_emmet_install_global = 0
  --     vim.g.user_emmet_leader_key = "<C-y>"
  --   end,
  -- },
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
    "proxy_key",
    dev = true,
    event = "VimEnter",
    config = true
  },
  {
    "llm_status",
    dev = true,
    ft = "codecompanion",
    config = true
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts ={
      stratgies = {
        chat = {
          adapter = "shopify",
        },
        inline = {
          adapter = "shopify",
        },
        slash_commands = {
          ["buffer"] = {
            opts = {
              provider = "fzf_lua"
            }
          }
        },
      },
      adapters = {
        shopify = function()
          return require("codecompanion.adapters").extend("openai", {
            url = "https://proxy.shopify.ai/v3/v1",
            env = {
              model = "anthropic:claude-3-5-sonnet",
              api_key = "cmd:openai_key cat",
            },
            schema = {
              model = "anthropic:claude-3-5-sonnet",
            },
          })
        end
      }
    }
  },
}
