return {
  {
    "Vigemus/iron.nvim",
    lazy = true,
    command = {
      "IronRepl",
      "IronReplHere",
      "IronRestart",
      "IronSend",
      "IronFocus",
      "IronWatch",
      "IronAttach"
    },
    main = "iron.core",
    opts = {
      config = {
        repl_definition = {
          ruby = {
            command = { "bundle", "exec", "irb", "--no-pager" },
          },
          rails = {
            command = { "bundle", "exec", "rails", "console", "--no-pager" },
          },
          gem = {
            command = { "bundle", "exec", "bin/console", "--no-pager" },
          },
          js = {
            node = {
              command = { "node" },
            },
          },
          elixir = {
            mix = {
              command = { "iex", "-S", "mix" },
            },
          },
          clojure = {
            lein = {
              command = { "lein", "repl" },
            },
          },
          typescript = {
            command = { "npx", "ts-node" },
          },
          python = function()
            return require("iron.fts.python").ipython
          end,
          sql = {
            pg = {
              command = { "pgcli", "-h", "0.0.0.0", "-U", "postgres" },
            },
            my = {
              command = { "mycli", "-u", "root", "-h", "0.0.0.0" },
            },
          },
        },
      },
      keymaps = {
        send_motion = "e",
        visual_send = "e",
        send_line = "ee",
      },
    }
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },
      "rcarriga/nvim-dap-ui",
      { "mxsdev/nvim-dap-vscode-js" },
      {
        "microsoft/vscode-js-debug",
        version = "1.x",
        build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
      },
      -- {
      --   dir = "~/src/github.com/suketa/nvim-dap-ruby",
      -- },
      "suketa/nvim-dap-ruby",
      {
        "mfussenegger/nvim-dap-python",
      },
    },
    config = function()
      local dap = require("dap")

      require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      })
      require("dap-ruby").setup()

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host, port = config.port })
      end

      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "attach",
            processId = require("dap.utils").pick_process,
            name = "Attach debugger to existing node process",
            sourceMaps = language == "typescript" and true,
            cwd = "${workspaceFolder}",
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
            outFiles = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
            skipFiles = { "**/node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "Launch",
            program = "${file}",
            name = "Launch File in Debugger",
            sourceMaps = language == "typescript" and true,
            cwd = "${workspaceFolder}",
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
            outFiles = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
            skipFiles = { "**/node_modules/**" },
          },
        }
      end

      dap.configurations["python"] = {
        {
          name = "Launch Test",
          type = "python",
          request = "launch",
          module = "pytest",
          args = { "${file}", "-sv", "--log-cli-level=INFO" },
          justMyCode = false,
        },
        {
          name = "Launch File",
          type = "python",
          request = "launch",
          program = "${file}",
          justMyCode = false,
        },
        {
          name = "Attach Process",
          type = "python",
          request = "attach",
          port = 5678,
          server = "127.0.0.1",
          justMyCode = false,
        },
      }

      dap.configurations["lua"] = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
          host = function()
            local value = vim.fn.input("Host [127.0.0.1]: ")
            if value ~= "" then
              return value
            end
            return "127.0.0.1"
          end,
          port = function()
            local val = tonumber(vim.fn.input("Port: "))
            assert(val, "Please provide a port number")
            return val
          end,
        },
      }
    end,
  },
  { "jbyuki/one-small-step-for-vimkind" },
}
