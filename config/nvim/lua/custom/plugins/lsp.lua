return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      require("lspconfig.ui.windows").default_options = {
        border = "single",
      }

      local lspconfig_defaults = require('lspconfig').util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig_defaults.capabilities,
        require('blink.cmp').get_lsp_capabilities()
      )
    end,
    opts = {
      codelens = {
        enabled = true
      }
    }
  },
  -- {
  --   "lukas-reineke/lsp-format.nvim",
  --   config = function()
  --     require("lsp-format").setup()
  --   end,
  -- },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "gopls",
        "lua-language-server",
        "pyright",
        "ruff",
        "ruby-lsp",
        "sorbet",
        "rust-analyzer",
        "typescript-language-server",
        "stylua",
        "prettier",
        "debugpy",
        "tflint",
        "terraform-ls",
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
      -- vim.api.nvim_create_augroup("LspFormatting", {})
      require("mason-lspconfig").setup()

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          -- local opts = {
          --   debounce_text_changes = 150,
          --   on_attach = function(client, bufnr)
          --     require("lsp-format").on_attach(client, bufnr)
          --     print("Formatting...")
          --   end,
          -- }

          require("lspconfig")[server_name].setup({})
        end,

        ["rust_analyzer"] = function()
          require("lspconfig")["rust_analyzer"].setup({})
        end,

        ["pyright"] = function()
          require("lspconfig")["pyright"].setup({
            on_new_config = function(config, root_dir)
              local python_path =
                  vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -e 2>/dev/null'))
              if string.len(python_path) > 0 then
                config.settings.python.pythonPath = python_path
              end
            end,
          })
        end,

        ["ruff"] = function()
          require("lspconfig")["ruff"].setup({
            init_options = {
              settings = {
                args = { "F", "E", "W", "I001" },
              },
            },
          })
        end,

        ["ruby_lsp"] = function()
          require("lspconfig")["ruby_lsp"].setup({
            enabledFeatureFlags = { ["tapiocaAddon"] = true },
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
      })
    end,
  },
  { "folke/neodev.nvim" },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua,
      }

      null_ls.setup({
        sources = sources,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") and vim.bo[bufnr].filetype ~= "yaml" then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ aysnc = true })
              end,
            })
          end
        end,
      })
    end,
  },
}
