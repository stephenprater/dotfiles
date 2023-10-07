return {
  {
    'Vigemus/iron.nvim',
    config = function()
      require("iron.core").setup({
        config = {
          repl_definition = {
            ruby = {
              command = { "pry", "--no-pager" }
            },
            rails = {
              command = { "bundle", "exec", "rails", "console" }
            },
            gem = {
              command = { "bundle", "exec", "bin/console" }
            },
            js = {
              node = {
                command = { "node" }
              },
            },
            elixir = {
              mix = {
                command = { "iex", "-S", "mix" }
              }
            },
            sql = {
              pg = {
                command = { "pgcli", "-h", "0.0.0.0", "-U", "postgres" }
              },
              my = {
                command = { "mycli", "-u", "root", "-h", "0.0.0.0" }
              },
            }
          },
        },
        keymaps = {
          send_motion = "e",
          visual_send = "e",
          send_line = "ee",
        }
      })
    end
  },
  {
    'mfussenegger/nvim-dap',
		dependencies = {
			'theHamsta/nvim-dap-virtual-text',
			{
				'rcarriga/nvim-dap-ui',
				config = function()
					require('dapui').setup()
				end
			} ,
			'rcarriga/nvim-dap-ui',
			{
				'mxsdev/nvim-dap-vscode-js',
				opts = {
					debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
					adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
				},
			},
			{
				'microsoft/vscode-js-debug',
				version = '1.x',
				build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
			},
			{
				'suketa/nvim-dap-ruby'
			},
      {
        'mfussenegger/nvim-dap-python',
      },
		},
    config = function()
      local dap = require('dap')

      require('dap-python').setup(vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python')

      dap.adapters.nlua = function(callback, config)
          callback({ type = 'server', host = config.host, port = config.port })
        end

      dap.configurations = {
        lua = {
          {
            type = 'nlua',
            request = 'attach',
            name = "Attach to running Neovim instance",
            host = function()
              local value = vim.fn.input('Host [127.0.0.1]: ')
              if value ~= "" then
                return value
              end
              return '127.0.0.1'
            end,
            port = function()
              local val = tonumber(vim.fn.input('Port: '))
              assert(val, "Please provide a port number")
              return val
            end
          }
        },
				typescript = {
					{
						type = 'pwa-node',
						request = 'attach',
						processId = require('dap.utils').pick_process,
						name = 'Attach debugger to existing node process',
						sourceMaps = true,
						cwd = '${workspaceFolder}',
						resolveSourceMapLocations = {
							'${workspaceFolder}/**',
							'!**/node_modules/**',
						},
						outFiles = {
							'${workspaceFolder}/**',
							'!**/node_modules/**',
						},
						skipFiles = { '**/node_modules/**' },
					},
				},
      }

    end
  },
	{ 'jbyuki/one-small-step-for-vimkind' }
}
