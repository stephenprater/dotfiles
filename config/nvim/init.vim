syntax on
filetype plugin indent on

set shell=bash
set hidden
set updatetime=300

"{{{ PLUGINS

"let &runtimepath.=",/Users/stephenprater/src/8thlight/coc.nvim/"

call plug#begin('~/.vimbundles')

"Finding Shit
Plug 'jremmen/vim-ripgrep'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/bufkill.vim'
Plug 'tpope/vim-projectionist'
Plug 'duff/vim-bufonly'
Plug 'tpope/vim-bundler'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'

" Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"* coc-yank	1.1.2	~/.config/coc/extensions/node_modules/coc-yank
"* coc-ultisnips	1.2.3	~/.config/coc/extensions/node_modules/coc-ultisnips
"* coc-lists	1.3.3	~/.config/coc/extensions/node_modules/coc-lists
"* coc-marketplace	1.5.0	~/.config/coc/extensions/node_modules/coc-marketplace
"+ coc-json	1.2.3	~/.config/coc/extensions/node_modules/coc-json
"+ coc-python	1.2.6	~/.config/coc/extensions/node_modules/coc-python
"+ coc-elixir	0.1.8	~/.config/coc/extensions/node_modules/coc-elixir
"+ coc-tsserver	1.4.2	~/.config/coc/extensions/node_modules/coc-tsserver"
"+ coc-java	1.4.5	~/.config/coc/extensions/node_modules/coc-java

" I write your plugins
Plug 'h1mesuke/vim-unittest'
Plug 'alexgenco/neovim-ruby'

"Clojure
" Plug 'guns/vim-clojure-static'
" Plug 'tpope/vim-leiningen'
" Plug 'tpope/vim-fireplace'
" Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Plug 'guns/vim-sexp'
" Plug 'vim-scripts/paredit.vim'
"
" Typescript
" Plug 'Quramy/tsuquyomi'
" Plug 'leafgarland/typescript-vim'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}

"Frontend
"Plug 'kchmck/vim-coffee-script'
"Plug 'tpope/vim-cucumber'
"Plug 'tpope/vim-haml'
"Plug 'wokalski/autocomplete-flow'
"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
"Plug 'mattn/emmet-vim'
"Plug 'moll/vim-node'
"Plug 'Galooshi/vim-import-js'

"Markdown / Diary
Plug 'rhysd/vim-gfm-syntax'
Plug 'nelstrom/vim-markdown-folding'
Plug 'SidOfc/mkdx'

"Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'andyl/vim-textobj-elixir'

"Ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'vim-ruby/vim-ruby'
Plug 'nelstrom/vim-textobj-rubyblock'
" Plug 'joker1007/vim-ruby-heredoc-syntax'

"Java
Plug 'tpope/vim-classpath'
Plug 'timjstewart/spring.vim'

"Python
" Plug 'Shougo/echodoc'
" Plug 'ambv/black'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Plug 'bps/vim-textobj-python'

"Go
" Plug 'fatih/vim-go'
" Plug 'sebdah/vim-delve'
"
"Hashicorp
" Plug 'hashivim/vim-terraform'
" Plug 'hashivim/vim-consul'
" Plug 'hashivim/vim-nomadproject'
" Plug 'hashivim/vim-packer'
" Plug 'hashivim/vim-vaultproject'
" Plug 'hashivim/vim-vagrant'

"JQ
Plug 'vito-c/jq.vim'

"Introspection
Plug 'majutsushi/tagbar'
Plug 'jgdavey/vim-blockle'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-endwise'
Plug 'adelarsq/vim-matchit'
Plug 'jiangmiao/auto-pairs'

"Shortcuts
Plug 'vim-scripts/swap-parameters'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'dhruvasagar/vim-table-mode'

"UI & Managment
"Plug 'Floobits/floobits-neovim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'terryma/vim-multiple-cursors'
Plug 'henrik/vim-qargs'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-rsi'
Plug 'simnalamburt/vim-mundo'
Plug 'jeetsukumaran/vim-markology'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/utl.vim'
Plug 'mattn/calendar-vim'
Plug 'kana/vim-textobj-syntax'
Plug 'whiteinge/diffconflicts'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tommcdo/vim-ninja-feet'
Plug 'tommcdo/vim-exchange'
Plug 'norcalli/nvim-colorizer.lua'

"REPL
Plug 'Vigemus/iron.nvim'
"

"TMUX
Plug 'christoomey/vim-tmux-navigator'
Plug 'jgdavey/tslime.vim'
Plug 'tpope/vim-tbone'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'roxma/vim-tmux-clipboard'

"Colorschemes
"Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'chrisbra/Colorizer'
"Plug 'luochen1990/rainbow'
"Plug 'altercation/vim-colors-solarized'
"Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
"Plug 'noah/vim256-color'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-colorscheme-switcher'

call plug#end()

"}}}
"
"{{{ SET INTERNALS
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

let &rtp.=",/Users/stephenprater/.vimbundles/neovim-ruby/"

colorscheme nord
colorscheme detailed_base
colorscheme detailed_ruby
colorscheme detailed_js

"set background=dark
"colorscheme solarized
"
"

"
let g:python_host_prog = '/Users/stephenprater/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/stephenprater/.pyenv/versions/neovim3/bin/python'

hi Italic cterm=italic gui=italic

"}}}

"{{{ CONFIGURE PLUGINS
let g:rainbow_active = 1

let g:rainbow_conf = {
\  'ctermfgs': [ 'brown', 'darkblue', 'darkgray', 'darkgreen', 'darkcyan', 'yellow', 'darkmagenta',
\              'brown', 'gray', 'black', 'darkmagenta', 'darkblue', 'darkgreen', 'darkcyan', 'darkgray'],
\  'guifgs': [ 'RoyalBlue3', 'SeaGreen3', 'DarkOrchid3', 'firebrick3', 'RoyalBlue3', 'SeaGreen3',
\               'DarkOrchid3', 'firebrick3', 'RoyalBlue3', 'SeaGreen3', 'DarkOrchid3', 'firebrick3',
\               'RoyalBlue3', 'SeaGreen3', 'DarkOrchid3', 'firebrick3'],
\  'operators': '_,_',
\  'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold']
\ }

let g:user_emmet_install_global = 0

let g:mundo_right = 1

let g:markology_enable = 0

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

let g:utl_cfg_hdl_scm_http = "silent !open -a Firefox '%u#%f'"

let g:airline_powerline_fonts = 1
let g:airline_theme = 'nord'
let g:airline#extensions#coc#enabled = 1

let g:UltiSnipsSnippetDirectories=["/Users/stephenprater/.config/nvim/ultisnips/"]
let g:UltiSnipsExpandTrigger           = '<C-y>'
let g:UltiSnipsJumpForwardTrigger      = '<C-a>'
let g:UltiSnipsJumpBackwardTrigger     = '<C-s>'

let g:coc_common_lists = {
      \ 'files': {'args': '', 'name': 'Files'},
      \ 'buffers': { 'args': '',  'name': 'Buffers'},
      \ 'grep': { 'args': '', 'name': 'Search'},
      \ 'tags': { 'args': '', 'name': 'Tags'},
      \ 'mru': { 'args': '-A', 'name': 'History' },
      \ 'lists': { 'args': '', 'name': 'Lists' }
      \}

function! CocPrettyListName(name)
  if has_key(g:coc_common_lists, a:name)
    return g:coc_common_lists[a:name]['name']
  else
    return a:name
  endif
endfunction

function! CocStatusLine(...)
  if &filetype == "list"
    let w:airline_section_a = '%{CocPrettyListName(get(b:list_status, "name"))}'
    let w:airline_section_b = '%{get(g:, "coc_list_loading_status", "")}'
    let w:airline_section_c = '(%L/%{get(b:list_status, "total", "")})'
    let w:airline_section_x = '%{get(b:list_status, "cwd", "")} %l/%L%*'
  endif
endfunction
call airline#remove_statusline_func('CocStatusLine')
call airline#add_statusline_func('CocStatusLine')

hi! default link CocCodeLens SpecialComment
hi! CocFloating guibg='#1B2126'

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

let g:markdown_fenced_languages = ['ruby', 'json', 'javascript']
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


luafile $HOME/.config/nvim/plugins.lua

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
autocmd FileType python call SemshiCustom()
autocmd BufWritePre *.py Black
autocmd BufWritePost *.py Semshi enable

autocmd BufWritePre *.yml silent! %s#\($\n\s*\)\+\%$##

autocmd BufNewFile,BufRead *.hcl set filetype=terraform

autocmd FileType json syntax match Comment +\/\/.\+$+

autocmd BufRead */log.md call s:EnableLogCommands()

autocmd FileType elixir let b:match_words='do:end,{:},(:),":"'

autocmd BufWritePre * call CocAction('format')

"}}}

"{{{ Custom Commands
command! -range SendSelectionToTerm :call <SID>SendVisualToTerm()<CR>
command! QuickFixOpenAll call QuickFixOpenAll()
command! -range RgVis :call <SID>RgVis()
" command! Repl :call REPLOpen(b:irepl)
command! -nargs=1 TmuxSend call Send_to_Tmux(<q-args> . '')

command! CreateSpec :execute 'Espec ' . substitute(expand('%:r'), 'app\/', '', '') . '!'

command! -bang -nargs=* Search call fzf#vim#ag(<q-args>, <bang>0)

" this needs to call a special function with an on_exit handler that
" autocloses the window when the process ends

command! Tig vsplit | startinsert | terminal tig
"}}}

"{{{ Maps
nnoremap <silent> <leader>A :Rg<CR>
vnoremap <silent> <leader>A :RgVis<CR>

nmap <silent> <M-m> :Utl<CR>
"
nmap <silent> ,yr :CocList yank<CR>
nmap <silent> ,tb :TagbarToggle<CR>
nmap <silent> ,gu :MundoToggle<CR>
nmap <silent> ,bs :CocList buffers<CR>

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

tnoremap <Esc> <C-\><C-n>

imap jj <ESC>

" navigate quickfix
map <silent> ,cn :cn<CR>
map <silent> ,cp :cp<CR>

" navigate tag list
map <silent> ,tn :tn<CR>
map <silent> ,tp :tp<CR>

nmap ,sp :call HighlightGroup()<cr>
nmap ,ss :call SynStack()<cr>
nmap dsar :silent call DeleteSurroundingBlock()<CR>

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

nmap <leader>ll :CocList<CR>
nnoremap <silent> <leader>lh :call CocAction('doHover')<CR>
nnoremap <silent> <leader>ld <Plug>(coc-definition)
nnoremap <silent> <leader>lr <Plug>(coc-rename)
nnoremap <silent> <leader>ls <Plug>(coc-document-symbols)
nnoremap <silent> <leader>l] <Plug>(coc-references)
nnoremap <silent> <leader>lf <Plug>(coc-format-selected)
vnoremap <silent> <leader>lf <Plug>(coc-format-selected)
nnoremap <silent> <leader>la <Plug>(coc-code-action)

nmap <C-p> :call <SID>coc_list('files')<CR>

nmap <silent> <leader>bc :silent .!bc<CR>
noremap <silent> <leader>d :.!date<CR>
nmap <silent> <leader>di :edit ~/Dropbox/dev-log/log.md<CR>

vnoremap <F6> :call <SID>PrettyPrint()<CR>

" easy out for git_diff_wrapper
map Q :qa

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


function! DeleteSurroundingBlock()
  let l:old_pos = getpos('.')
  let s:comment_escape = '\v^[^#]*'
  let s:block_openers = '\zs(<def>|<if>|<do>|<module>|<class>)'
  let s:start_pattern = s:comment_escape . s:block_openers
  let s:end_pattern = s:comment_escape . '\zs<end>'
  let s:skip_pattern = 'getline(".") =~ "\\v\\S\\s<(if|unless)>\\s\\S"'

  let s:flags = 'W'

  call searchpair(s:start_pattern,'',s:end_pattern, s:flags, s:skip_pattern)
  let end_pos = line('.')

  " Jump to match
  normal %
  let start_pos = line('.')

  execute 'silent ' . end_pos . 'd'
  execute 'silent ' . start_pos . 'd'
  normal =ir

  call setpos('.', l:old_pos)
endfunction

"}}}

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

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

function! s:_find_buffers_with_var(varname, expr)
    let l:results = []
    for l:bni in range(1, bufnr("$"))
        if !bufexists(l:bni)
            continue
        endif
        let l:bvar = getbufvar(l:bni, "")
        if empty(a:varname)
            call add(l:results, l:bni)
        elseif has_key(l:bvar, a:varname) && empty(a:expr)
            call add(l:results, l:bni)
        elseif has_key(l:bvar, a:varname) && l:bvar[a:varname] =~ a:expr
            call add(l:results, l:bni)
        endif
    endfor
    return l:results
endfunction


function! s:_find_buffers_with_type(type)
    let l:results = []
    for l:bni in range(1, bufnr("$"))
        if !bufexists(l:bni)
            continue
        endif
        let l:bvar = getbufvar(l:bni, "&filetype")
        if l:bvar =~ a:type
            call add(l:results, l:bni)
        endif
    endfor
    return l:results
endfunction
"}}}

"{{{ Multiple Cursor Hooks
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists('g:deoplete#disable_auto_complete')
    let g:deoplete#disable_auto_complete = 1
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists('g:deoplete#disable_auto_complete')
    let g:deoplete#disable_auto_complete = 0
  endif
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

"{{{ CocList "next type" naviation
function! s:coc_get_list(completion_type, ...)
  let l:coc_keys = keys(g:coc_common_lists)
  let l:max_index = len(l:coc_keys) - 1
  let l:current_type = get(a:,1, "")
  if a:completion_type == 'next'
    let l:next_index = index(l:coc_keys, l:current_type) + 1

    if l:next_index > l:max_index
      return l:coc_keys[0] . ' ' . g:coc_common_lists[l:coc_keys[0]]['args']
    else
      return l:coc_keys[l:next_index] . ' ' . g:coc_common_lists[l:coc_keys[l:next_index]]['args']
    endif
  elseif a:completion_type == 'prev'
    let l:prev_index = index(l:coc_keys, l:current_type) - 1

    if l:prev_index < 0
      return l:coc_keys[0] . ' ' . g:coc_common_lists[l:coc_keys[0]]['args']
    else
      return l:coc_keys[l:prev_index] . ' ' . g:coc_common_lists[l:coc_keys[l:prev_index]]['args']
    endif
  else
    return a:completion_type . ' ' . g:coc_common_lists[a:completion_type]['args']
  end
endfunction

function! CocNextList(coc_context)
  call coc#util#close(win_getid(winnr()))
  execute win_id2win(a:coc_context['winid'])."wincmd w"
  execute('CocList '.s:coc_get_list('next', a:coc_context['name']))
endfunction

function! CocPrevList(coc_context)
  call coc#util#close(win_getid(winnr()))
  execute win_id2win(a:coc_context['winid'])."wincmd w"
  execute('CocList '.s:coc_get_list('prev', a:coc_context['name']))
endfunction

function! s:coc_list(completion_type)
  execute('CocList '.s:coc_get_list(a:completion_type))
endfunction
"}}}

"{{{ Log Functions
"
function! s:EnableLogCommands()
  command! -range=% FiveLs <line1>,<line2>call ListFiveLs()
  command! -range=% Todos <line1>,<line2>call ListTodos()
  command! -range=% Links <line1>,<line2>call ListLinks()
endfunction

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

function! SemshiCustom()
  hi clear semshiSelected
  hi semshiSelected guifg='#CF7B43'
endfunction
"}}}


" vim: set ts=2 sw=2 tw=78 et fdm=marker:
