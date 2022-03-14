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

