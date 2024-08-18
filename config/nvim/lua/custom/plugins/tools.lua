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
    "yacineMTB/dingllm.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local system_prompt = [[
      You should replace the code that you are sent, only following the comments.
      Do not talk at all.
      Only output valid code.
      Do not provide any backticks that surround the code.
      Never ever output backticks like this ```.
      Any comment that is asking you for something should be removed after you satisfy them.
      Other comments should left alone.
      Do not output backticks
    ]]
      local helpful_prompt = [[
    You are a helpful assistant.
    What I have sent are my notes so far.
    You are very curt, yet helpful.
    ]]

      local dingllm = require("dingllm")
      local proxy_key = require("functions").shopify_proxy_key()

      if proxy_key == nil then
        vim.notify("No Shopify Proxy Key found", "error")
      end

      local function openai_replace()
        dingllm.invoke_llm_and_stream_into_editor({
          url = proxy_key.base .. "/v1/chat/completions",
          model = "gpt-4o",
          api_key = proxy_key.key,
          system_prompt = system_prompt,
          replace = true,
        }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
      end

      local function openai_help()
        dingllm.invoke_llm_and_stream_into_editor({
          url = proxy_key.base .. "/v1/chat/completions",
          model = "gpt-4o",
          api_key = proxy_key.key,
          system_prompt = helpful_prompt,
          replace = false,
        }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
      end

      vim.keymap.set({ "n", "v" }, "<leader>ar", openai_replace, { desc = "Replace code with Open AI Response" })
      vim.keymap.set({ "n", "v" }, "<leader>aq", openai_help, { desc = "Replace question with Open AI Response" })
    end,
  },
}
