return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- LSP / Treesitter
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
  use 'RRethy/nvim-treesitter-textsubjects'
  use 'nvim-treesitter/playground'
  use 'p00f/nvim-ts-rainbow'

  -- Autocomplete
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'

  -- Snippets
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- FZF
  use {'junegunn/fzf', run = ':call fzf#install(})'}
  use 'junegunn/fzf.vim'
  use 'vijaymarupudi/nvim-fzf'
  use 'vijaymarupudi/nvim-fzf-commands'
  use 'gfanto/fzf-lsp.nvim'
  -- RG
  use 'jremmen/vim-ripgrep'

  -- File Navigation
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('nvim-tree').setup {} end
  }
  use 'tpope/vim-projectionist'

  -- YankRing
  use 'bfredl/nvim-miniyank'

  -- Neorg
  -- use {
  --     "nvim-neorg/neorg",
  --     requires = "nvim-lua/plenary.nvim"
  --  }

  -- Markdown / Diary
  use 'rhysd/vim-gfm-syntax'
  use 'nelstrom/vim-markdown-folding'
  use 'SidOfc/mkdx'
  use 'dkarter/bullets.vim'


  -- Text Objects / Pairs
  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-syntax'
  use 'andymass/vim-matchup'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-ragtag'
  use 'windwp/nvim-autopairs'

  -- StatusLine
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-lua/lsp-status.nvim'

  -- UI Affordances
  use 'terryma/vim-multiple-cursors'
  use 'machakann/vim-swap'
  use 'simnalamburt/vim-mundo'
  use 'jeetsukumaran/vim-markology'
  use 'vim-scripts/utl.vim'
  use 'norcalli/nvim-colorizer.lua'
  use 'duff/vim-bufonly'
  use 'majutsushi/tagbar'

  use 'godlygeek/tabular'

  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-speeddating'

  use 'tpope/vim-fugitive'
  use 'tpope/vim-git'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-rsi'
  use 'mattn/calendar-vim'
  use 'whiteinge/diffconflicts'
  use 'tommcdo/vim-ninja-feet'
  use 'tommcdo/vim-exchange'

  -- Colorscheme
  use 'arcticicestudio/nord-vim'

  -- Elixir
  use 'elixir-editors/vim-elixir'
  use 'andyl/vim-textobj-elixir'

  -- Debugger
  use 'Vigemus/iron.nvim'
  use 'mfussenegger/nvim-dap'
  use 'jbyuki/one-small-step-for-vimkind'

  -- Tmux
  use 'christoomey/vim-tmux-navigator'
  use 'jgdavey/tslime.vim'
  use 'tpope/vim-tbone'
  use 'janko-m/vim-test'
  use 'tpope/vim-dispatch'
  use 'roxma/vim-tmux-clipboard'

--[[
"Plug 'tpope/vim-bundler'
"Plug 'justinmk/vim-dirvish'
"Plug 'justinmk/vim-sneak'
"Plug 'ludovicchabant/vim-gutentags'
"" Plug 'nvim-lua/popup.nvim'
"" Plug 'nvim-lua/plenary.nvim'
"" Plug 'nvim-telescope/telescope.nvim'

"" Language Server

"" Plug 'neovim/nvim-lspconfig'
"" Plug 'kabouzeid/nvim-lspinstall'
"" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"" Plug 'hrsh7th/nvim-compe'

"Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
"Plug 'junegunn/fzf.vim' " needed for previews
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
"Plug 'antoinemadec/coc-fzf'
"" * coc-yank	1.1.8	~/.dotfiles/config/coc/extensions/node_modules/coc-yank
"" * coc-eslint	1.3.2	~/.dotfiles/config/coc/extensions/node_modules/coc-eslint
"" * coc-ultisnips	1.2.3	~/.dotfiles/config/coc/extensions/node_modules/coc-ultisnips
"" * coc-lists	1.3.10	~/.dotfiles/config/coc/extensions/node_modules/coc-lists
"" * coc-prettier	1.1.20	~/.dotfiles/config/coc/extensions/node_modules/coc-prettier
"" * coc-rls	1.1.6	~/.dotfiles/config/coc/extensions/node_modules/coc-rls
"" * coc-marketplace	1.8.0	~/.dotfiles/config/coc/extensions/node_modules/coc-marketplace
"" + coc-json	1.2.6	~/.dotfiles/config/coc/extensions/node_modules/coc-json
"" + coc-tsserver	1.4.13	~/.dotfiles/config/coc/extensions/node_modules/coc-tsserver
"" + coc-java	1.5.3	~/.dotfiles/config/coc/extensions/node_modules/coc-java
"" + coc-elixir	0.6.1	~/.dotfiles/config/coc/extensions/node_modules/coc-elixir
"" + coc-python	1.2.13	~/.dotfiles/config/coc/extensions/node_modules/coc-python
"" + coc-omnisharp	0.0.28	~/.dotfiles/config/coc/extensions/node_modules/coc-omnisharp

"" I write your plugins
"" Plug 'h1mesuke/vim-unittest'
"" Plug 'alexgenco/neovim-ruby'

""Clojure
"" Plug 'guns/vim-clojure-static'
"" Plug 'tpope/vim-leiningen'
"" Plug 'tpope/vim-fireplace'
"" Plug 'tpope/vim-sexp-mappings-for-regular-people'
"" Plug 'guns/vim-sexp'
"" Plug 'vim-scripts/paredit.vim'
""
"" Typescript
"" Plug 'Quramy/tsuquyomi'
"" Plug 'leafgarland/typescript-vim'
"" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
""

"" DOTNET
"" Plug 'OmniSharp/omnisharp-vim'

"" RUST
"" Plug 'cespare/vim-toml'

"""Frontend
"" Plug 'tpope/vim-haml'
"" Plug 'mxw/vim-jsx'
"" Plug 'moll/vim-node'
"" Plug 'Galooshi/vim-import-js'
"" Plug 'leafgarland/typescript-vim'
"" Plug 'kchmck/vim-coffee-script'
"" Plug 'briancollins/vim-jst'
""
"" Plug 'pangloss/vim-javascript'
"" Plug 'mattn/emmet-vim'
"" Plug 'mvolkmann/vim-js-arrow-function'

""Markdown / Diary
"" Plug 'rhysd/vim-gfm-syntax'
"" Plug 'nelstrom/vim-markdown-folding'
"" Plug 'SidOfc/mkdx'
"" Plug 'dkarter/bullets.vim'

""Elixir

""Ruby
"" Plug 'tpope/vim-rails'
"" Plug 'tpope/vim-rake'
"" Plug 'vim-ruby/vim-ruby'
"" Plug 'nelstrom/vim-textobj-rubyblock'
"" Plug 'joker1007/vim-ruby-heredoc-syntax'
"" Plug 'jgdavey/vim-blockle'

""Java
"" Plug 'tpope/vim-classpath'
"" Plug 'timjstewart/spring.vim'

""Python
"" Plug 'Shougo/echodoc'
"" Plug 'ambv/black'
"" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"" Plug 'bps/vim-textobj-python'

""Go
"" Plug 'fatih/vim-go'
"" Plug 'sebdah/vim-delve'
""
""Hashicorp
"" Plug 'hashivim/vim-terraform'
"" Plug 'hashivim/vim-consul'
"" Plug 'hashivim/vim-nomadproject'
"" Plug 'hashivim/vim-packer'
"" Plug 'hashivim/vim-vaultproject'
"" Plug 'hashivim/vim-vagrant'

""JQ
"Plug 'vito-c/jq.vim'

""Introspection
"Plug 'majutsushi/tagbar'
"Plug 'jgdavey/vim-blockle'
"Plug 'kana/vim-textobj-user'
"Plug 'tpope/vim-endwise'
"Plug 'adelarsq/vim-matchit'
"Plug 'jiangmiao/auto-pairs'

""Shortcuts
"Plug 'machakann/vim-swap'
"Plug 'godlygeek/tabular'
"Plug 'tpope/vim-abolish'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-speeddating'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-unimpaired'
"Plug 'dhruvasagar/vim-table-mode'

""UI & Managment
""Plug 'Floobits/floobits-neovim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-git'
"Plug 'terryma/vim-multiple-cursors'
"Plug 'henrik/vim-qargs'
"Plug 'tpope/vim-ragtag'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-sleuth'
"Plug 'tpope/vim-rsi'
"Plug 'simnalamburt/vim-mundo'
"Plug 'jeetsukumaran/vim-markology'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'vim-scripts/utl.vim'
"Plug 'mattn/calendar-vim'
"Plug 'kana/vim-textobj-syntax'
"Plug 'whiteinge/diffconflicts'
"Plug 'tommcdo/vim-ninja-feet'
"Plug 'tommcdo/vim-exchange'
"Plug 'norcalli/nvim-colorizer.lua'

""REPL
"Plug 'Vigemus/iron.nvim'
"Plug 'mfussenegger/nvim-dap'

""TMUX
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'jgdavey/tslime.vim'
"Plug 'tpope/vim-tbone'
"Plug 'janko-m/vim-test'
"Plug 'tpope/vim-dispatch'
"Plug 'roxma/vim-tmux-clipboard'

""Colorschemes
""Plug 'morhetz/gruvbox'
"Plug 'arcticicestudio/nord-vim'
"Plug 'chrisbra/Colorizer'
""Plug 'luochen1990/rainbow'
"Plug 'altercation/vim-colors-solarized'
"Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
"Plug 'noah/vim256-color'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-colorscheme-switcher'
]]--

end)
