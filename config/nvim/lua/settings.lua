local iron = require('iron')

iron.core.add_repl_definitions{
  ruby = {
    pry = {
      command = {"pry"}
    }
  },
  elixir = {
    mix = {
      command = {"iex", "-S", "mix"}
    }
  },
  sql = {
    pg = {
      command = {"pgcli", "-h", "0.0.0.0", "-U", "postgres"}
    }
  }
}

iron.core.set_config {
  preferred = {
    python = "ipython",
    clojure = "lein",
    ruby = "pry",
    elixir = "mix"
  }
}

local colorizer = require('colorizer')
colorizer.setup()

local dap = require('dap')

dap.adapters.elixir = {
  type = 'executable';
  command = os.getenv('HOME') .. '/.local/share/nvim/lspinstall/elixir/elixir-ls/debugger.sh'
}

dap.configurations.elixir = {
  {
  type = 'elixir';
  request = 'launch' ;
  name = 'mix phx.server';
  program = 'mix';
  task = "phx.server";
  programsArgs = { 'run' };
  projectDir = "${workspaceFolder}"
  }
}

dap.configurations.lua = {
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
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port })
end

local lualine = require('lualine')
local lsp_status = require('lsp-status')
lsp_status.register_progress()

local function lsp_status_segment()
  lsp_status.status()
end

lualine.setup({
  theme = 'nord',
  lualine_y = {
    'progress',
    lsp_status_segment
  }
})

local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format(
      {
        with_text=false,
        max_width=50
      }
    )
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'ultisnips'},
    {name = 'buffer'}
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
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  }
})

local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
 require('lspconfig')[server].setup{
    capabilities = vim.tbl_extend('keep', cmp_capabilities, lsp_status.capabilities),
    on_attach = lsp_status.on_attach
  }
end)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

function _G.fzf_files()
  require('fzf-commands').files({
    fzf = function(contents, options)
      vim.cmd "20split"
      return require('fzf').provided_win_fzf(contents, options)
    end
  })
end

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({
  check_ts = true,
  disable_filetype = { "FZF" },
})

npairs.add_rules({
  Rule("do ", "\nend", {"elixir", "ruby"})
})

require('nvim-treesitter.configs').setup({
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
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

require('nvim-tree').setup({})
