local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = "\\"

require("lazy").setup({
  ui = {
    border = "single",
  },
  spec = {
    { import = "custom.plugins" },
    {
      "vhyrro/luarocks.nvim",
      priority = 1000,
      config = true,
    },
    {
      "proxy_key",
      dir = "./.local-plugins/proxy_key",
      config = function()
        require("local-plugins.proxy_key").setup()
      end,
    },
    {
      "list_ring",
      dir = "./local-plugins/list_ring",
      config = function()
        require("local-plugins.list_ring").setup({
          lists = {
            {
              cmd = "Buffers",
            },
            {
              cmd = "History",
            },
            {
              cmd = "Files",
            },
            {
              cmd = "FzfGrep",
            },
            {
              args = "lsp_workplace_symbols",
              cmd = "FzfLua",
              cond = function()
                local cap = vim.lsp.buf_clients({ bufnr = vim.current.buffer }).server_capabilities
                if cap and cap["workspaceSymbolProvder"] then
                  return true
                else
                  return false
                end
              end,
            },
          },
        })
      end,
    },
  },
})
