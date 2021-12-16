syntax on
filetype plugin indent on

if(!$SPIN)
  set shell=/opt/homebrew/bin/zsh
else
  set shell=/usr/bin/zsh
endif

set hidden
set updatetime=300
runtime macros/matchit.vim

syntax on
filetype plugin indent on

set timeout
set timeoutlen=750
set ttimeoutlen=0
set wildmenu
set wildmode=full
set number
set expandtab
set listchars=tab:\|\ ,eol:¬,extends:❯,precedes:❮
set visualbell
set splitright
set splitbelow
set noshowmode

set hidden

set verbosefile=~/verbose.log
set inccommand=nosplit
set termguicolors

set completeopt=menu,menuone,noselect

hi Italic cterm=italic gui=italic

"{{{ PLUGINS

"let &runtimepath.=",/Users/stephenprater/src/8thlight/coc.nvim/"

let g:vimspector_enable_mappings = 'HUMAN'

luafile ~/.config/nvim/lua/plugins.lua
luafile ~/.config/nvim/lua/settings.lua

"{{{ SET INTERNALS

" let &rtp.=",/Users/stephenprater/.vimbundles/neovim-ruby/"

colorscheme nord
colorscheme detailed_base
colorscheme detailed_ruby
colorscheme detailed_js

highlight Pmenu guifg=#D8DEE9 guibg=#333333
"}}}

"{{{ CONFIGURE PLUGINS
"

let g:bullets_enabled_file_types = [ 'markdown' ]

let g:user_emmet_install_global = 0

let g:mundo_right = 1

let g:markology_enable = 0

let g:python3_host_prog = '/Users/stephenprater/.asdf/installs/python/3.8.10/bin/python'

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

let g:utl_cfg_hdl_scm_http = "silent !open -a Firefox '%u#%f'"

let g:airline_powerline_fonts = 1
let g:airline_theme = 'nord'
let g:airline#extensions#coc#enabled = 0

let g:UltiSnipsSnippetDirectories=["/Users/stephenprater/.config/nvim/ultisnips/"]
let g:UltiSnipsExpandTrigger           = '<C-y>'
let g:UltiSnipsJumpForwardTrigger      = '<C-a>'
let g:UltiSnipsJumpBackwardTrigger     = '<C-s>'

let g:coffee_compiler = "./node_modules/.bin/coffee"
let g:coffee_linter = "./node_modules/./bin/coffeelint"


let g:fzf_common_lists = [
      \ ['files', {'args': '', 'name': 'Files'}],
      \ ['buffers', { 'args': '',  'name': 'Buffers'}],
      \ ['history-files', { 'args': '-A', 'name': 'History' }],
      \ ['rg', { 'args': '', 'name': 'Grep'}],
      \ ['tags', { 'args': '', 'name': 'Tags'}],
      \]

call textobj#user#plugin('coderegion', {
      \ 'code': {
      \   'select-a-function': 'CodeRegionA',
      \   'select-i-function': 'CodeRegionI',
      \   'select-a': 'ac',
      \   'select-i': 'ic',
      \ },
      \ })

let g:codefence_eval = {
      \ 'mmdc': ['mmdc', '-i', '<infile>', '-o', '<outfile>'],
      \}

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


let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

let g:go_autodetect_gopath = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_bin_path = "/Users/stephenprater/golang/bin/"
let g:go_metalinter_disabled = ['vet']

let g:ruby_operators = 1

let g:markdown_fenced_languages = ['ruby', 'json', 'javascript', 'sql', 'elixir']
let g:gfm_syntax_highlight_inline_code = 1
let g:gfm_syntax_emoji_conceal = 1
let g:mkdx#settings = {
      \ 'checkbox': { 'toggles': [' ', '-', 'x' ],
      \               'update_tree': 2,
      \               'initial_state': ' ' },
      \ 'highlight': { 'enable': 1 },
      \ 'map': { 'prefix': '<leader>', 'enable': 1 }
      \ }
" because you'll check here again the map for 'toggle checkbox' is <leader>-


let g:python_highlight_all = 1
let g:jedi#pop_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#environment_paths = [$HOME . '/.pyenv/versions']

let g:echodoc#enable_at_startup = 1

let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
let g:gutentags_file_list_command = {
  \ 'markers': {
    \ '.git': 'git ls-files',
  \}
\}

let g:OmniSharp_server_stdio = 1


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

autocmd BufRead */log.md call s:EnableLogCommands()
autocmd BufRead */log.md lua require('cmp').setup.buffer { enabled = false }

autocmd FileType elixir let b:match_words='do:end,{:},(:),":"'

autocmd BufWritePre elixir lua vim.lsp.buf.formatting()
autocmd BufWritePre ruby lua vim.lsp.buf.formatting()
autocmd BufWritePre python lua vim.lsp.buf.formatting()
autocmd BufWritePre javascript lua vim.lsp.buf.formatting()

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

" this needs to call a special function with an on_exit handler that
" autocloses the window when the process ends

command! Tig vsplit | startinsert | terminal tig


command! TSReset write | edit | TSBufEnable highlight
"}}}

"{{{ Maps
nnoremap <silent> <leader>A :Rg<CR>
vnoremap <silent> <leader>A :RgVis<CR>

nmap <silent> <D-CR> :Utl<CR>
"
nmap <silent> ,yr :CocList yank<CR>
nmap <silent> ,tb :TagbarToggle<CR>
nmap <silent> ,gu :MundoToggle<CR>
nmap <silent> ,bs :Buffers<CR>

" nmap <C-x> :bd %<CR>

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


nmap <leader>m :MarkologyToggle<CR>

nmap <silent> <leader>bc :silent .!bc<CR>
noremap <silent> <leader>d :Dirvish %:p<CR>
noremap <silent> <leader>da :.!date<CR>
nmap <silent> <leader>di :edit ~/Dropbox/dev-log/log.md<CR>

map Q :qa

"}}}

au FileType ruby ab edn end
au FileType ruby ab bpry require 'pry'; binding.pry
au FileType python ab bpry breakpoint()
au FileType python ab rpdb import remote_pdb; remote_pdb.RemotePdb('0.0.0.0', 4444).set_trace()
au FileType python ab pdb import pdb; pdb.set_trace()
au FileType elixir ab edn end
au FileType elixir ab bpry require IEx; IEx.pry

"{{{ Abbreviations
ab recieve receive
ab schema$ "$schema": "http://json-schema.org/draft-06/schema#",
"}}}

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

" Copy all the matches from the last search into the unnamed
" register
function! CopyMatches() range
  let hits = []
  silent execute a:firstline . ',' . a:lastline . 's//\=add(hits, submatch(0))/ge'
  let @" = join(hits, "\n")
  silent execute 'u'
endfunction

"}}}

"{{{ Enable Migration Commands
function! s:EnableMigrationCommands()
  let l:current_file = expand('%')
  if expand('%') !~ 'db/migrate'
    return
  endif

  command! RmigrateDown call s:Migrate('down', matchlist(expand('%'), 'db\/migrate\/\([0-9]\+\)_')[1])
  command! RmigrateUp call s:Migrate('up', matchlist(expand('%'), 'db\/migrate\/\([0-9]\+\)_')[1])
endfunction

function! s:Migrate(direction, migration)
  let $VERSION = a:migration
  exe 'Dispatch bundle exec rake db:migrate:'. a:direction
endfunction
"}}}
"
function! s:fzf_miniyank(put_before, fullscreen) abort
    function! Sink(opt, line) abort
        let l:key = substitute(a:line, ' .*', '', '')
        if empty(a:line) | return | endif
        let l:yanks = miniyank#read()[l:key]
        call miniyank#drop(l:yanks, a:opt)
    endfunction

    let l:put_action = a:put_before ? 'P' : 'p'
    let l:name = a:put_before ? 'YanksBefore' : 'YanksAfter'
    let l:spec = {}
    let l:spec['source'] = map(miniyank#read(), {k,v -> k.' '.join(v[0], '\n')})
    let l:spec['sink'] = {val -> Sink(l:put_action, val)}
    let l:spec['options'] = '--no-sort --prompt="Yanks-'.l:put_action.'> "'
    call fzf#run(fzf#wrap(l:name, l:spec, a:fullscreen))
endfunction

function! s:fzf_symbols(put_before, fullscreen) abort
    function! Sink(opt, line) abort
        let l:key = substitute(a:line, ' .*', '', '')
        if empty(a:line) | return | endif
        let l:yanks = luaeval("vim.lsp.buf.document_symbol()")
        call miniyank#drop(l:yanks, a:opt)
    endfunction

endfunction

command! -bang YanksBefore call s:fzf_miniyank(1, <bang>0)
command! -bang YanksAfter call s:fzf_miniyank(0, <bang>0)

nmap ,yr :YanksAfter<CR>
nmap ,yr :YanksBefore<CR>

"{{{ Log Functions
"
function! s:EnableLogCommands()
  command! -range=% FiveLs <line1>,<line2>call ListFiveLs()
  command! -range=% Todos <line1>,<line2>call ListTodos()
  command! -range=% Links <line1>,<line2>call ListLinks()
endfunction

" function! FiveLs()
"   append ["launched", "learned", "liked", "lacked", "laud"]
" endfunction

function! ListFiveLs() range
  call setloclist(0, [])
  for theEl in ['launched', 'lacked', 'learned', 'liked', 'laud']
    execute a:firstline.",".a:lastline . "lvimgrepa /" . l:theEl . "/j" . fnameescape(bufname("%"))
  endfor
  execute "CocList locationlist"
endfunction

function! ListTodos() range
  let l:pattern = "-\\s\\[[ \\-]\\].*$"
  execute a:firstline.",".a:lastline . "lvimgrep /" . l:pattern . "/j" . fnameescape(bufname("%"))
  execute "CocList locationlist"
endfunction

function! ListLinks() range
  let l:pattern = "<url:.*$"
  execute a:firstline.",".a:lastline . "lvimgrep /" . l:pattern . "/j" . fnameescape(bufname("%"))
  execute "CocList locationlist"
endfunction

function! EvalRegion() range
  " get the first line of the visual selection and look up the evaller based
  " on the gfm syntax marker

  let evaler = matchstr(getline(a:firstline), ".*$", 3)
  if has_key(g:codefence_eval, evaler)
    let infile = tempname()
    let outfile = tempname()
    let eval_cmd = []
    for element in copy(g:codefence_eval[evaler])
      if element == '<infile>'
        call add(eval_cmd, infile)
      elseif element == '<outfile>'
        call add(eval_cmd, outfile)
      else
        call add(eval_cmd, element)
      endif
    endfor
    echo eval_cmd
    " execute a:firstline + 1 . "," . a:lastline - 1 . "w!" . tempfile
  else
    echoerr "No defined interpreter for region type " . evaler
  endif
endfunction

function! CodeRegionA()
  let [startline, startcol] = searchpos('```','nbW')
  let [endline, endcol] = searchpos('```','neW')
  return ['V', [0, startline, startcol,0], [0,endline, endcol,0]]
endfunction

function! CodeRegionI()
  let [startline, startcol] = searchpos('```','nbW')
  let [endline, endcol] = searchpos('```','neW')
  call setpos('.',[0,endline-1,1])
  normal! $
  let [_, endline, endcol, _] = getpos('.')
  return ['v', [0,startline+1, 1,0], [0,endline, endcol,0]]
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

