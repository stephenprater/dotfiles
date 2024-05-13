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
      "zidhuss/neotest-minitest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-minitest"),
          require("neotest-vitest"),
          require("neotest-python"),
        },
      })
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
    "robitx/gp.nvim",
    config = function()
      if vim.fn.executable("openai_key") == 1 then
        vim.fn.system("openai_key")
      else
        vim.notify("Who are you? You're not running this in Prater's dotfiles.", vim.log.levels.ERROR)
        return
      end

      local file = io.open(os.getenv("HOME") .. "/.oai-proxy-details", "r")
      if not file then
        vim.notify("No proxy details found.", vim.log.levels.ERROR)
        return
      end

      local data = file:read("*a")
      file:close()
      local proxy_info = vim.fn.json_decode(data)

      gp = require("gp")

      gp.setup({
        openai_api_key = proxy_info.key,
        openai_api_endpoint = proxy_info.base .. "/v1/chat/completions",
        chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>c<Enter>" },
        chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cx" },
        chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cs" },
        chat_user_prefix = "👤:",
      })

      vim.keymap.set({ "v", "o", "x" }, "<leader>cr", ":GpImplement<CR>", { noremap = true })

      require("which-key").register({
        ["<leader>"] = {
          name = "Chat",
          ["cc"] = { ":GpChatNew", "Chat" },
        },
      })
    end,
  },
}
