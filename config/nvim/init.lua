if vim.g.vscode then
  return
end

if vim.env["SPIN"] then
  vim.o.shell = "/usr/bin/zsh"
else
  vim.o.shell = "/opt/homebrew/bin/zsh"
  vim.g.clipboard = {
    name = "tmux",
    copy = {
      ["+"] = { "tmux", "load-buffer", "-" },
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = { "tmux", "save-buffer", "-" },
      ["*"] = "pbpaste",
    },
    cache_enabled = 0,
  }
end

vim.opt.backspace = "indent,eol,start"
vim.opt.laststatus = 3
vim.opt.listchars = { tab = "│ ", eol = "¬", extends = "❯", precedes = "❮" }
vim.opt.pumblend = 30
vim.opt.scrolloff = 5
vim.opt.showmatch = true
vim.opt.sidescrolloff = 5
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 750
vim.opt.ttimeoutlen = 0
vim.opt.verbosefile = vim.fn.expand("~") .. "/vim-verbose.log"
vim.opt.visualbell = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.o.number = true

vim.g.mapleader = "/"
vim.g.maplocalleader = "//"

vim.g.vsnip_snippit_dir = vim.fn.expand("~") .. "/.config/nvim/snippets"

vim.g.utl_cfg_hdl_scm_http = "silent !open -a chrome '%u#%f'"

vim.g.fzf_lsp_timeout = 1000
vim.g.fzf_layout = {
  window = "horizontal above 30new",
}

vim.g.miniyank_maxitems = 100

-- Configure Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

require("plugins")

vim.cmd.colorscheme("kanagawa-wave")
-- vim.cmd.colorscheme("detailed_base")
-- vim.cmd.colorscheme("detailed_ruby")
-- vim.cmd.colorscheme("detailed_js")

vim.cmd([[ highlight NonText guifg=#34342d ]])
vim.cmd([[ highlight Pmenu guifg=#D8DEE9 guibg=#333333 ]])
vim.cmd([[ highlight clear VertSplit ]])
vim.cmd([[ highlight VertSplit ctermfg=8 guifg=#434c5e ]])
vim.cmd([[ highlight NotifyBackground guibg=#161616 ]])
vim.cmd([[ hi link Attribute Macro ]])
vim.cmd([[ hi Italic cterm=italic gui=italic ]])
vim.cmd([[ hi clear NvimTreeNormal ]])
vim.cmd([[ hi clear NormalFloat ]])
vim.cmd([[ hi link NormalFloat Normal]])
vim.cmd([[ hi clear WhichKeyFloat ]])
vim.cmd([[ hi link WhichKeyFloat NormalFloat ]])
vim.cmd([[ hi link WhichKeyBorder VertSplit ]])
vim.cmd([[ hi MiniIndentscopeSymbol guifg=#54546d ]])
vim.cmd([[ hi LineNr guifg=#54546d guibg=#1f1f28 ]])
vim.cmd([[ hi link FoldColumn LineNr ]])
vim.cmd([[ hi clear SignColumn ]])
vim.cmd([[ hi link SignColumn LineNr ]])
vim.cmd([[ hi WinSeparator guifg=#3a3a57 guibg=#1f1f28 ]])
vim.cmd([[ hi FloatBorder guifg=#54546d guibg=#1f1f28 ]])
vim.cmd([[ hi NavicSeparator guifg=#63748c ]])
vim.cmd([[ hi NavicText guifg=#afafaf guibg=#1f1f28 ]])

vim.keymap.set({ "t", "n" }, "<M-h>", "<C-\\><C-n><C-w>h", { noremap = true })
vim.keymap.set({ "t", "n" }, "<M-j>", "<C-\\><C-n><C-w>j", { noremap = true })
vim.keymap.set({ "t", "n" }, "<M-k>", "<C-\\><C-n><C-w>k", { noremap = true })
vim.keymap.set({ "t", "n" }, "<M-l>", "<C-\\><C-n><C-w>l", { noremap = true })
vim.keymap.set("v", "r", ":lua require('functions').replace_motion('visual')", { noremap = true, silent = true })

-- Move visual block up and down a line
vim.keymap.set("v", "J", ">+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", "<-2<CR>gv=gv", { noremap = true })

vim.keymap.set("ia", "recieve", "receive", {})

vim.keymap.set("c", "<C-O>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-A>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-X><C-A>", "<C-A>", { noremap = true })

vim.keymap.set("n", "q:", ":FzfLua command_history<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("Trim", "<line1>,<line2>s/\\s\\+$//e", {
  range = "%",
  bar = true,
})

vim.api.nvim_create_user_command("LspDebug", function()
  vim.lsp.set_log_level("debug")
  vim.cmd("terminal tail -f '" .. vim.lsp.get_log_path() .. "'")
end, {})

vim.api.nvim_create_user_command(
  "FzfGrep",
  "call fzf#vim#grep(\"rg --glob '!sorbet' --column --line-number --no-heading --color=always --smart-case -- \".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)",
  { bang = true, nargs = "*" }
)

vim.api.nvim_create_user_command("EnableTerminalEscape", function()
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, buffer = true })
end, {})

vim.api.nvim_create_user_command("DisableTerminalEscape", function()
  vim.keymap.del("t", "<Esc>", { buffer = true })
end, {})

vim.api.nvim_create_user_command("RefreshAiProxyKey", ":lua require('proxy_key').get_proxy_key()", {})

vim.api.nvim_create_user_command("TSReset", "write | edit | TSBufEnable highlight", {})

vim.api.nvim_create_autocmd("TermOpen", { pattern = "fzf", command = "tunmap <Esc>" })
vim.api.nvim_create_autocmd("TermOpen", { command = ":let b:miniindentscope_disable = v:true" })

vim.api.nvim_create_autocmd("BufWritePre", { command = "Trim" })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.py" },
  callback = function()
    vim.schedule(function()
      local poetry_site_package = vim.trim(
        vim.fn.system(
          'cd "'
          .. vim.fn.expand("%:p:h")
          .. '"; poetry run python -c "import site; print(site.getsitepackages()[0])" 2>/dev/null'
        )
      )
      if vim.fn.getenv("PYTHONPATH") == poetry_site_package then
        return
      end

      vim.fn.setenv("PYTHONPATH", poetry_site_package)
      vim.print("PYTHONPATH set to" .. poetry_site_package, "info")
    end)
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "norg",
  command = "setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() tw=80 sw=2",
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "norg",
  command = "Copilot disable"
})
