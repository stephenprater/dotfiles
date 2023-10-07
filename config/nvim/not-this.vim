"{{{ PLUGINS
"{{{ Autocommands
autocmd FileType ruby let b:surround_114 = "do \r end"
autocmd BufNewFile,BufRead *.hcl set filetype=terraform
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufWritePre *.yml silent! %s#\($\n\s*\)\+\%$##
"}}}
"
"{{{ Custom Commands
command! -bar -range=% Trim :<line1>,<line2>s/\s\+$//e
command! -range RgVis :call <SID>RgVis()
command! LspDebug lua vim.lsp.set_log_level("debug"); vim.cmd('terminal tail -f ' .. vim.lsp.get_log_path())
command! -bang -nargs=* FzfGrep call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
command! TSReset write | edit | TSBufEnable highlight
command! -bar -range=% Trim :<line1>,<line2>s/\s\+$//e



command! -range SendSelectionToTerm :call <SID>SendVisualToTerm()<CR>
command! QuickFixOpenAll call QuickFixOpenAll()
" command! Repl :call REPLOpen(b:irepl)
command! -nargs=1 TmuxSend call Send_to_Tmux(<q-args> . '')
command! CreateSpec :execute 'Espec ' . substitute(expand('%:r'), 'app\/', '', '') . '!'
command! -bar -range=% NotRocket :<line1>,<line2>s/:\(\w\+\)\s*=>/\1:/ge

" this needs to call a special function with an on_exit handler that
" autocloses the window when the process ends
command! Tig vsplit | startinsert | terminal tig


"}}}

"{{{ Maps

" VSnip
imap <expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
smap <expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
imap <expr> <C-n> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-n>'
imap <expr> <C-p> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-p>'

map Y       y$
nnoremap <silent> <Esc><Esc> :nohls<CR>
nmap <silent> <D-CR> :Utl<CR>


" Enable TAB indent and SHIFT-TAB unindent
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

nnoremap <silent> <leader>A :Rg<CR>
vnoremap <silent> <leader>A :RgVis<CR>


vnoremap <silent> r :call ReplaceMotion('visual')

au TermOpen * tnoremap <Esc> <C-\><C-n>
au FileType fzf tunmap <Esc>

imap jj <ESC>

noremap ,ts :TmuxSend <C-r><C-w>
noremap <leader>p :call Send_to_Tmux('pry ' . expand('<cword>') . '')
noremap ,q :TmuxSend quit<CR>
vnoremap ,ts :SendSelectionToTerm<CR>
noremap T :TmuxSend<Space>


nmap <leader>db :lua require('dap').toggle_breakpoint()<CR>
command! Debugger lua require('dapui').open(); require('dap').continue()
command! NvimDebug lua require('osv').launch()

nmap <silent> <leader>bc :silent .!bc<CR>
noremap <silent> <leader>da :.!date<CR>
nmap <silent> <leader>di :Neorg workspace log<CR>

iunmap \|

"}}}


"{{{ Abbreviations
au FileType ruby ab edn end
au FileType ruby ab bpry require 'pry'; binding.pry
au FileType ruby ab dbg require 'debug'; binding.break
au FileType python ab bpry breakpoint()
au FileType python ab rpdb import remote_pdb; remote_pdb.RemotePdb('0.0.0.0', 4444).set_trace()
au FileType python ab pdb import pdb; pdb.set_trace()
au FileType elixir ab edn end
au FileType elixir ab bpry require IEx; IEx.pry
ab recieve receive
"}}}
