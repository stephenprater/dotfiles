"{{{ set internals
syntax on
filetype plugin indent on

if(!$SPIN)
  set shell=/opt/homebrew/bin/zsh
else
  set shell=/usr/bin/zsh
  let g:clipboard = {
  \   'name': 'myClipboard',
  \   'copy': {
  \      '+': ['tmux', 'load-buffer', '-'],
  \      '*': ['pbcopy'],
  \    },
  \   'paste': {
  \      '+': ['tmux', 'save-buffer', '-'],
  \      '*': ['pbpaste'],
  \   },
  \   'cache_enabled': 1,
  \ }
endif

set autoindent
set autoread
set backspace=indent,eol,start
set completeopt=menu,menuone,noselect
set display=lastline " When lines are cropped at the screen bottom, show as much as possible
set expandtab
set hidden
set inccommand=nosplit
set incsearch
set laststatus=2    " Always show status line
set list            " show trailing whitespace and tabs
set listchars=tab:\|\ ,eol:¬,extends:❯,precedes:❮
set modelines=5
set noshowmode
set number
set scrolloff=1
set showcmd
set showmatch
set sidescrolloff=5
set smarttab
set splitbelow
set splitright
set termguicolors
set timeout
set timeoutlen=750
set ttimeoutlen=0
set undodir=~/.local/state/nvim/undo
set undofile
set updatetime=300
set verbosefile=~/verbose.log
set visualbell
set wildmenu
set wildmode=full

colorscheme nord
colorscheme detailed_base
colorscheme detailed_ruby
colorscheme detailed_js

highlight Pmenu guifg=#D8DEE9 guibg=#333333
hi Italic cterm=italic gui=italic

runtime macros/matchit.vim

"{{{ PLUGINS


luafile ~/.config/nvim/lua/plugins.lua
luafile ~/.config/nvim/lua/settings.lua

"{{{ CONFIGURE PLUGINS
"
let g:user_emmet_install_global = 0
let g:mundo_right = 1
let g:markology_enable = 0
let g:tagbar_ctags_bin = '/opt/homebrew/bin/ctags'

if(!$SPIN)
  let g:python3_host_prog = '/Users/stephenprater/.asdf/installs/python/3.8.10/bin/python'
endif

function! NoClearSlime(cmd) abort
  call Send_to_Tmux(a:cmd . "\n")
endfunction

function! DockerTransform(cmd) abort
  if exists('b:docker_prefix')
    let l:new_cmd = substitute(a:cmd, 'pipenv\srun', '', '')
    return b:docker_prefix . " " . l:new_cmd
  elseif exists('g:docker_prefix')
    let l:new_cmd = substitute(a:cmd, 'pipenv\srun', '', '')
    return g:docker_prefix . " " . l:new_cmd
  else
    return a:cmd
  endif
endfunction

let g:test#custom_strategies = {'noclearslime': function('NoClearSlime')}
let g:test#strategy = 'noclearslime'
let g:test#custom_transformations = { 'docker': function('DockerTransform') }
let g:test#transformation = 'docker'
let g:test#javascript#jest#file_pattern = '\v(test|spec)\.(js|jsx|coffee|ts|tsx)$'
let g:test#javascript#jest#options = {
  \ 'nearest': '--runInBand --forceExit',
  \ 'file': '--runInBand --forceExit',
  \}

let g:test#javascript#karma#file_pattern = '\v(test|spec).*(js|jsx|coffee|ts|tsx)$'

let g:utl_cfg_hdl_scm_http = "silent !open -a chrome '%u#%f'"

let g:fzf_common_lists = [
      \ ['files', {'args': '', 'name': 'Files'}],
      \ ['buffers', { 'args': '',  'name': 'Buffers'}],
      \ ['history-files', { 'args': '-A', 'name': 'History' }],
      \ ['rg', { 'args': '', 'name': 'FzfGrep'}],
      \]

function! FzfNextList()
  let l:buf = nvim_get_current_buf()
  let l:name = nvim_buf_get_var(l:buf, "fzf")["name"]
  execute ":q"
  execute "sleep 100m"
  for l:list_idx in range(len(g:fzf_common_lists))
    if g:fzf_common_lists[l:list_idx][0] == l:name
      if l:list_idx - 1 > len(g:fzf_common_lists)
        execute g:fzf_common_lists[0][1]["name"]
      else
        execute g:fzf_common_lists[l:list_idx + 1][1]["name"]
      endif
    endif
  endfor
endfunction

function! FzfPrevList()
  let l:buf = nvim_get_current_buf()
  let l:name = nvim_buf_get_var(l:buf, "fzf")["name"]
  execute ":q"
  execute "sleep 100m"
  for l:list_idx in range(len(g:fzf_common_lists))
    if g:fzf_common_lists[l:list_idx][0] == l:name
      if l:list_idx < 0
        execute g:fzf_common_lists[0][1]["name"]
      else
        execute g:fzf_common_lists[l:list_idx - 1][1]["name"]
      endif
    endif
  endfor
endfunction

let g:fzf_lsp_timeout = 1000
let g:fzf_layout = { 'down': '30%' }

let g:ruby_heredoc_syntax_filetypes = {
        \ "jq" : {
        \   "start" : "JQ",
        \},
        \ "ruby": {
        \   "start" : "RUBY",
        \},
        \ "sql": {
        \   "start" : "SQL",
        \},
        \ "liquid": {
        \   "start" : "LIQUID",
        \},
  \}

let g:miniyank_maxitems = 100
"}}}

"{{{ Autocommands
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd BufNewFile,BufRead,BufEnter *.agsv set filetype=agsv
autocmd FileType agse,agsv RainbowParentheses!
autocmd User BufEnterRails call s:EnableMigrationCommands()
autocmd FileType html,css EmmetInstall
autocmd BufWritePre * silent Trim

autocmd FileType ruby let b:surround_114 = "do \r end"

autocmd FileType python let b:docker_prefix='docker-compose run --service-ports web'
autocmd FileType python setlocal completeopt-=preview

autocmd BufWritePre *.yml silent! %s#\($\n\s*\)\+\%$##

autocmd BufNewFile,BufRead *.hcl set filetype=terraform

autocmd FileType json syntax match Comment +\/\/.\+$+

autocmd FileType norg setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() tw=80 sw=2
autocmd FileType norg Copilot disable

autocmd FileType elixir let b:match_words='do:end,{:},(:),":"'

autocmd BufWritePre elixir lua vim.lsp.buf.formatting()
autocmd BufWritePre ruby lua vim.lsp.buf.formatting()
autocmd BufWritePre python lua vim.lsp.buf.formatting()
autocmd BufWritePre javascript lua vim.lsp.buf.formatting()
autocmd BufWritePre typescript lua vim.lsp.buf.formatting()

autocmd FileType javascript nmap <leader>b :call JsArrowFnBraceToggle()<CR>

autocmd FileType elixir TSBufEnable highlight
autocmd FileType elixir TSBufEnable rainbow
autocmd FileType elixir TSBufEnable incremental_selection
autocmd FileType elixir TSBufEnable lsp_interop
autocmd FileType elixir TSBufEnable move
autocmd FileType elixir TSBufEnable select
autocmd FileType elixir TSBufEnable indent
autocmd FileType elixir TSBufEnable matchup

autocmd FileType python TSBufEnable highlight
autocmd FileType python TSBufEnable rainbow
autocmd FileType python TSBufEnable incremental_selection
autocmd FileType python TSBufEnable lsp_interop
autocmd FileType python TSBufEnable move
autocmd FileType python TSBufEnable select
autocmd FileType python TSBufEnable indent
autocmd FileType python TSBufEnable matchup

autocmd Filetype luadev call s:EnableLuaCommands()

"}}}

"{{{ Custom Commands
command! -bar -range=% Trim :<line1>,<line2>s/\s\+$//e
command! -range SendSelectionToTerm :call <SID>SendVisualToTerm()<CR>

command! QuickFixOpenAll call QuickFixOpenAll()
command! -range RgVis :call <SID>RgVis()
" command! Repl :call REPLOpen(b:irepl)
command! -nargs=1 TmuxSend call Send_to_Tmux(<q-args> . '')

command! CreateSpec :execute 'Espec ' . substitute(expand('%:r'), 'app\/', '', '') . '!'

command! -bang -nargs=* Search call fzf#vim#ag(<q-args>, <bang>0)

command! LspDebug lua vim.lsp.set_log_level("debug"); vim.cmd('terminal tail -f ' .. vim.lsp.get_log_path())
command! -bang -nargs=* FzfGrep call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
" this needs to call a special function with an on_exit handler that
" autocloses the window when the process ends

command! Tig vsplit | startinsert | terminal tig


command! TSReset write | edit | TSBufEnable highlight

command! -bar -range=% Trim :<line1>,<line2>s/\s\+$//e
command! -bar -range=% NotRocket :<line1>,<line2>s/:\(\w\+\)\s*=>/\1:/ge



"}}}

"{{{ Maps

" VSnip
imap <expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
smap <expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
imap <expr> <C-n> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-n>'
imap <expr> <C-p> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-p>'

map Y       y$
nnoremap <silent> <Esc><Esc> :nohls<CR>
inoremap <C-C> <Esc>`^

cnoremap <C-O> <Up>
inoremap ø <C-O>o
inoremap <M-o> <C-O>o
inoremap <C-A> <C-O>^
inoremap <C-X><C-@> <C-A>
cnoremap <C-A> <Home>
cnoremap <C-X><C-A> <C-A>
" If at end of a line of spaces, delete back to the previous line.
" Otherwise, <Left>
inoremap <silent> <C-B> <C-R>=getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"<CR>
cnoremap          <C-B> <Left>
" If at end of line, decrease indent, else <Del>
inoremap <silent> <C-D> <C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"<CR>
" If at end of line, list matches, else <Del>
cnoremap   <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
" If at end of line, copy character below, else <End>
inoremap <silent> <C-E> <C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-E>":"\<Lt>End>"<CR>
" If at end of line, fix indent, else <Right>
inoremap <silent> <C-F> <C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"<CR>
" if at end of line, open command-line window, else <Right>
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?"\<Lt>C-F>":"\<Lt>Right>"

noremap  <F1>   <Esc>
noremap! <F1>   <Esc>

" Enable TAB indent and SHIFT-TAB unindent
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

nnoremap <silent> <leader>A :Rg<CR>
vnoremap <silent> <leader>A :RgVis<CR>

nmap <silent> <D-CR> :Utl<CR>

nmap <silent> ,tb :TagbarToggle<CR>
nmap <silent> ,gu :UndotreeToggle<CR>
nmap <silent> ,bs :Buffers<CR>

nmap <silent> q: :History:<CR>

nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

nmap e <Plug>(iron-send-motion)
vmap e <Plug>(iron-visual-send)
nmap ee <Plug>(iron-send-line)

noremap <silent> r :set opfunc=ReplaceMotion<CR>g@
vnoremap <silent> r :call ReplaceMotion('visual')
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

"window controls
noremap ]- <C-W>-
noremap ]= <C-W>+
noremap ], <C-W>>
noremap ]. <C-W><
noremap ]j <C-W>
noremap ]k <C-W>k
noremap ]h <C-W>h
noremap ]l <C-W>l

noremap ]_ :split<CR>
noremap ]\| :vsplit<CR>
noremap ]o :bn<CR>
noremap ]p :bp<CR>
noremap ]} :tabnext<CR>
noremap ]{ :tabprev<CR>

au TermOpen * tnoremap <Esc> <C-\><C-n>
au FileType fzf tunmap <Esc>
au FileType fzf tnoremap <buffer> <C-p> <C-\><C-n>:call FzfNextList()<CR>
au FileType fzf tnoremap <buffer> <C-n> <C-\><C-n>:call FzfPrevList()<CR>

nmap <C-p> :Files<CR>

imap jj <ESC>

" navigate quickfix
map <silent> ,cn :cn<CR>
map <silent> ,cp :cp<CR>

" navigate tag list
map <silent> ,tn :tn<CR>
map <silent> ,tp :tp<CR>

nmap ,sp :call HighlightGroup()<cr>
nmap ,ss :call SynStack()<cr>

noremap ,ts :TmuxSend <C-r><C-w>
noremap <leader>p :call Send_to_Tmux('pry ' . expand('<cword>') . '')
noremap ,q :TmuxSend quit<CR>
vnoremap ,ts :SendSelectionToTerm<CR>
noremap T :TmuxSend<Space>

tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
nnoremap <M-h> <C-\><C-n><C-w>h
nnoremap <M-j> <C-\><C-n><C-w>j
nnoremap <M-k> <C-\><C-n><C-w>k
nnoremap <M-l> <C-\><C-n><C-w>l

nmap <leader>lh :lua vim.lsp.buf.hover()<CR>
nmap <leader>ld :lua vim.lsp.buf.definition()<CR>
nmap <leader>lr :lua vim.lsp.buf.rename()<CR>
nmap <leader>l? :lua vim.lsp.buf.signature_help()<CR>
nmap <leader>l] :References<CR>
nmap <leader>la :CodeActions<CR>
nmap <leader>lx :lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<CR>
nmap <leader>ls :lua vim.lsp.buf.document_symbol()<CR>

nmap <leader>db :lua require('dap').toggle_breakpoint()<CR>
nmap <F12> :lua require('dapui').open(); require('dap').continue()<CR>

command! NvimDebug lua require('osv').launch()

nmap <leader>m :MarkologyToggle<CR>

nmap <silent> <leader>bc :silent .!bc<CR>
noremap <silent> <leader>da :.!date<CR>
nmap <silent> <leader>di :edit ~/log/prater.norg<CR>

"}}}


"{{{ Abbreviations
au FileType ruby ab edn end
au FileType ruby ab bpry require 'pry'; binding.pry
au FileType python ab bpry breakpoint()
au FileType python ab rpdb import remote_pdb; remote_pdb.RemotePdb('0.0.0.0', 4444).set_trace()
au FileType python ab pdb import pdb; pdb.set_trace()
au FileType elixir ab edn end
au FileType elixir ab bpry require IEx; IEx.pry
ab recieve receive
"}}}
"
noremap <silent> el <Plug>(Luadev-RunLine)
noremap <silent> e :set opfunc=Luadev_run_operator<CR>g@
vnoremap <silent> e :call Luadev_run_operator(v:true)<CR>

" thanks to @xolox on stackoverflow
function! Luadev_run_operator(is_op)
    let [lnum1, col1] = getpos(a:is_op ? "'<" : "'[")[1:2]
    let [lnum2, col2] = getpos(a:is_op ? "'>" : "']")[1:2]

    if lnum1 > lnum2
      let [lnum1, col1, lnum2, col2] = [lnum2, col2, lnum1, col1]
    endif

    let lines = getline(lnum1, lnum2)
    if  a:is_op == v:true || lnum1 == lnum2
        let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][col1 - 1:]
    end
    let lines =  join(lines, "\n")."\n"
    call v:lua.require'luadev'.exec(lines)
endfunction

"{{{ Functions
"
function! ReplaceMotion(type)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use gv command.
    echomsg "visual invoke"
    silent exe "normal! r0"
  elseif a:type == 'line'
    silent exe "normal! `[V`]c0"
  else
    silent exe "normal! `[v`]c0"
  endif

  let &selection = sel_save
  let @@ = reg_save
endfunction


"{{{ Ag
function! s:RgVis()
  let l:old_r = @r
  let @r = GetVisual()[0]
  execute "silent Rg ".@r
  let @r = l:old_r
endfunction
"}}}

"{{{ Utility
function! QuickFixOpenAll()
  if empty(getqflist())
      return
  endif
  let s:prev_val = ""
  for d in getqflist()
    let s:curr_val = bufname(d.bufnr)
    if (s:curr_val != s:prev_val)
        exec "edit " . s:curr_val
    endif
    let s:prev_val = s:curr_val
  endfor
endfunction

function! GetVisual()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][:col2 - 2]
  let lines[0] = lines[0][col1 - 1:]
  return lines
endfunction

"}}}
"
"{{{ fzf extensions
function! s:fzf_miniyank(put_before, fullscreen) abort
    function! LocalSink(opt, line) abort
        let l:key = substitute(a:line, ' .*', '', '')
        if empty(a:line) | return | endif
        let l:yanks = miniyank#read()[l:key]
        call miniyank#drop(l:yanks, a:opt)
    endfunction

    let l:put_action = a:put_before ? 'P' : 'p'
    let l:name = a:put_before ? 'YanksBefore' : 'YanksAfter'
    let l:spec = {}
    let l:spec['source'] = map(miniyank#read(), {k,v -> k.' '.join(v[0], '\n')})
    let l:spec['sink'] = {val -> LocalSink(l:put_action, val)}
    let l:spec['options'] = '--no-sort --prompt="Yanks-'.l:put_action.'> "'
    call fzf#run(fzf#wrap(l:name, l:spec, a:fullscreen))
endfunction

function! s:fzf_symbols(put_before, fullscreen) abort
    function! LocalSink(opt, line) abort
        let l:key = substitute(a:line, ' .*', '', '')
        if empty(a:line) | return | endif
        let l:yanks = luaeval("vim.lsp.buf.document_symbol()")
        call miniyank#drop(l:yanks, a:opt)
    endfunction
endfunction

command! -bang YanksBefore call s:fzf_miniyank(1, <bang>0)
command! -bang YanksAfter call s:fzf_miniyank(0, <bang>0)

function! Launched() abort
  exec "vimgrep /📕/ " . expand("%")
endfunction

nmap ,yr :YanksAfter<CR>
nmap ,yr :YanksBefore<CR>

function! s:EnableLuaCommands()
  echomsg "Enabling Lua Commands"
  nmap <buffer> <leader>e <Plug>(Luadev-RunLine)
  omap <buffer> <leader>e <Plug>(Luadev-Run)
  nmap <buffer> <leader>w <Plug>(Luadev-RunWord)
endfunction
"}}}
"
"}}}
"
"{{{ Syntax Highlighting

function! HighlightGroup()
  let l:syndict = {}
  let syndict["higlight"] = synIDattr(synID(line("."),col("."),1),"name")
  let syndict["trans"] = synIDattr(synID(line("."),col("."),0),"name")
  let syndict["lolight"] = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
  let syndict["fg_col"] = synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")
  echo syndict
endfunction

" Show syntax highlighting groups for word under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"}}}
