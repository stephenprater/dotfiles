vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.diagnostic.config({ float = { border = "single" } })

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
			local cmp_capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local lsp_status = require("lsp-status")
			require("mason-lspconfig").setup()

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local opts = {
						debounce_text_changes = 150,
						capabilities = vim.tbl_extend("keep", cmp_capabilities, lsp_status.capabilities),
						on_attach = function(client, buffer)
							if server_name == "tsserver" then
								client.server_capabilities["textDocument/formatting"] = false
								client.server_capabilities["documentRange/formatting"] = false
							end

							if client.supports_method("textDocument/formatting") then
								vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
								vim.api.nvim_create_autocmd("BufWritePost", {
									group = augroup,
									buffer = buffer,
									callback = function()
										vim.lsp.buf.format({
											bufnr = buffer,
											timeout_ms = 2000,
											async = true,
											filter = function(lsp_client)
												return lsp_client.name == "null-ls"
											end,
										})
									end,
								})
							end

							lsp_status.on_attach(client)
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
            end
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
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {},
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint,
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.eslint_d.with({
            prefer_local = "node_modules/.bin"
          }),
					require("typescript.extensions.null-ls.code-actions"),
				},
			})
		end,
	},

	{
		"jose-elias-alvarez/typescript.nvim",
		config = function()
			require("typescript").setup({
				disable_commands = true,
			})
		end,
	},
}
