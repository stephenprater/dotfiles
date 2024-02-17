return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig.ui.windows").default_options = {
				border = "single",
			}
		end,
	},
  {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require('lsp-format').setup()
    end
  },
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"gopls",
				"lua-language-server",
				"pyright",
				"ruby-lsp",
				"rust-analyzer",
				"sorbet",
				"typescript-language-server",
				"stylua",
				"prettier",
        "debugpy",
			},
		},
		config = function(_, opts)
			require("mason").setup({
				keymaps = {
					help = "?",
					apply_language_filter = "/",
				},
			})

			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
        end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      require("mason-lspconfig").setup()

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local opts = {
						debounce_text_changes = 150,
						on_attach = function(client, bufnr)
              require("lsp-format").on_attach(client, bufnr)
              vim.notify("Formatting")
            end,
					}

					require("lspconfig")[server_name].setup(opts)
				end,

				["rust_analyzer"] = function()
					require("lspconfig")["rust_analyzer"].setup({})
				end,

       ['pyright'] = function()
          require("lspconfig")["pyright"].setup({
            on_new_config = function(config, root_dir)
              local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
              if string.len(env) > 0 then
                config.settings.python.pythonPath = env .. '/bin/python'
              end
            end,
          })
        end,

				["lua_ls"] = function()
					require("lspconfig")["lua_ls"].setup({
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim", "use" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
							},
						},
					})
				end,

				["sorbet"] = function()
					require("lspconfig")["sorbet"].setup({
						cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--no-config", "--dir", "." },
					})
				end,
			})
		end,
	},
  {
    "karloskar/poetry-nvim",
    config = function()
      require('poetry-nvim').setup()
    end
  },
	{ "folke/neodev.nvim" },
	{
		"jose-elias-alvarez/typescript.nvim",
		config = function()
			require("typescript").setup({
				disable_commands = true,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.eslint_d.with({
            prefer_local = "node_modules/.bin"
          }),
					require("typescript.extensions.null-ls.code-actions"),
				},
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.notify("Formatting...")
                vim.lsp.buf.format({ aysnc = true })
              end,
            })
          end
        end,
			})
		end,
	}
}
