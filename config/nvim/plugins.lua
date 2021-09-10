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
  command = os.getenv('HOME') .. '/.config/coc/extensions/node_modules/coc-elixir/els-release/debugger.sh'
}

dap.configurations.elixir = {
  {
    type = 'elixir';
    request = 'launch' ;
    name = 'Launch File';
    program = 'mix';
    programsArgs = { 'run' };
  }
}

-- local lspinstall = require('lspinstall')

-- local function setup_servers()
--   lspinstall.setup()
--   local servers = lspinstall.installed_servers()
--   for _, server in pairs(servers) do
--     require('lspconfig')[server].setup{}
--   end
-- end

-- setup_servers()

-- lspinstall.post_install_hook = function ()
--   setup_servers()
--   vim.cmd("bufdo e")
-- end

-- local lspconfig = require('lspconfig')

-- lspconfig.sumneko_lua.setup{
--   settings = {
--     Lua = {
--       workspace = {
--         maxPreload = 10000,
--       },
--       diagnostics = {
--         globas = { 'vim' }
--       }
--     }
--   }
-- }

-- lspconfig.elixir.setup{}

-- local telescope = require('telescope')
-- local telescope_actions = require('telescope.actions')

-- local telescope_next_list = function(prompt_buffer)
--   local picker = telescope_actions.get_current_picker(prompt_buffer)
--   local picker_ins = vim.inspect(picker)
--   vim.cmd("echomsg" .. picker_ins)
-- end

-- require('telescope').setup{
--   defaults = {
--     mappings = {
--       i = {
--         ["<C-p>"] = telescope_next_list,
--         ["<C-n>"] = false
--       }
--     }
--   }
-- }
