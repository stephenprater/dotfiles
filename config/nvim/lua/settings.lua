require('colorizer').setup()

local lsp_status = require('lsp-status')
lsp_status.register_progress()

local function lsp_status_segment()
  lsp_status.status()
end

local custom_nord = require('lualine.themes.nord')
custom_nord.normal.c.bg = "#161616"
custom_nord.normal.b.bg = "#161616"
custom_nord.normal.a.bg = "#161616"

require('lualine').setup({
  options = { theme = custom_nord },
  lualine_y = {
    'progress',
    lsp_status_segment
  }
})

local sts = require('syntax-tree-surfer')
local sts_opts = { noremap = true, silent = true }

-- Swapping Nodes in Visual Mode
vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", sts_opts)
vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", sts_opts)
vim.keymap.set("x", "J", '<cmd>STSSelectNextSiblingNode<cr>', sts_opts)
vim.keymap.set("x", "K", '<cmd>STSSelectPrevSiblingNode<cr>', sts_opts)
vim.keymap.set("x", "H", '<cmd>STSSelectParentNode<cr>', sts_opts)
vim.keymap.set("x", "L", '<cmd>STSSelectChildNode<cr>', sts_opts)
vim.keymap.set("x", "<A-j>", '<cmd>STSSwapNextVisual<cr>', sts_opts)
vim.keymap.set("x", "<A-k>", '<cmd>STSSwapPrevVisual<cr>', sts_opts)

vim.keymap.set("n", "gt", function()
  sts.targeted_jump({
    "module",
    "class",
    "method",
    "if",
    "do_block",
    "block"
  })
end)

require("iron.core").setup({
  config = {
    should_map_plug = true,
    repl_definition = {
      ruby = {
        command = { "pry" }
      },
      rails = {
        command = { "bundle", "exec", "rails", "console" }
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
  }
})

local dap = require('dap')

dap.adapters = {
    nlua = function(callback, config)
      callback({ type = 'server', host = config.host, port = config.port })
    end,
    pwa_node = require('dap-js').connect
  }

dap.configurations = {
    lua = {
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
    },
    typescript = {
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        continueOnAttach = true,
        attachExistingChildren = true,
        port = 9229
      },
    },
  }

require('dapui').setup()

local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format(
      {
        with_text = false,
        max_width = 50
      }
    )
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'neorg' }
  }),
  completion = {
    completeopt = 'menu,menuone,noinsert',
    autcomplete = true
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  }
})

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("mason").setup({
  keymaps = {
    help = "?",
    apply_language_filter = "/",
  }
})
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers({
  function(server_name)
    local opts = {
      capabilities = vim.tbl_extend('keep', cmp_capabilities, lsp_status.capabilities),
      on_attach = function(client, buffer)
        if server_name == "tsserver" then
          client.server_capabilities["textDocument/formatting"] = false
          client.server_capabilities["documentRange/formatting"] = false

          local ts_utils = require("nvim-lsp-ts-utils")
          ts_utils.setup({})
          ts_utils.setup_client(client)
        end

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = buffer,
            callback = function()
              vim.lsp.buf.format({ bufnr = buffer, timeout_ms = 2000, async = true })
            end,
          })
        end

        lsp_status.on_attach(client)
      end
    }

    require("lspconfig")[server_name].setup(opts)
  end,

  ["sumneko_lua"] = function()
    require("lspconfig")["sumneko_lua"].setup({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { 'vim', 'use' }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          }
        }
      }
    })
  end,

  ["solargraph"] = function()
    require("lspconfig")["solargraph"].setup({
      settings = {
        solargraph = {
          formatting = false,
        }
      }
    })
  end,

  ["sorbet"] = function()
    require("lspconfig")["sorbet"].setup({
      cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--no-config", "--dir", "." }
    })
  end,
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.gitsigns,
  },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require('gitsigns').setup({})

function _G.fzf_files()
  require('fzf-commands').files({
    fzf = function(contents, options)
      vim.cmd "20split"
      return require('fzf').provided_win_fzf(contents, options)
    end
  })
end

if not os.getenv("SPIN") then
  local neorg = require('neorg')
  neorg.setup({
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {
        config = {
          icons = {
            todo = {
              undone = {
                icon = " "
              }
            }
          }
        }
      },
      ["core.export"] = {
        config = {
          export_dir = "~/log/"
        }
      },
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp"
        }
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            log = "~/log"
          },
          index = "prater.norg"
        }
      },
    }
  })
end

require('nvim-treesitter.configs').setup({
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  },

  endwise = {
    enable = true
  },

  matchup = {
    enable = true
  },

  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner"
      }
    },
  },

  playground = {
    enabled = true,
    updatetime = 25,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'h',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },

  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer'
    }
  }
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup({})

require("indent_blankline").setup({
  show_end_of_line = true
})
