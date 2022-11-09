local ensure_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

if not vim.api.nvim_list_uis() == {} then
  packer.init {
    max_jobs = 5,
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end
    }
  }
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  use 'bfredl/nvim-luadev'

  -- LSP / Treesitter
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
  use 'RRethy/nvim-treesitter-textsubjects'
  use 'RRethy/nvim-treesitter-endwise'
  use 'nvim-treesitter/playground'
  use 'p00f/nvim-ts-rainbow'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  -- Debugger
  use { 'stephenprater/iron.nvim', branch = "attach-and-no-deprecation" }
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'rcarriga/nvim-dap-ui'
  use 'jbyuki/one-small-step-for-vimkind'

  -- Autocomplete
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'
  use 'github/copilot.vim'

  -- Snippets
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'rafamadriz/friendly-snippets'

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
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons'
  }
  use 'tpope/vim-projectionist'

  -- YankRing
  use 'bfredl/nvim-miniyank'

  -- Markdown / Diary
  -- use 'rhysd/vim-gfm-syntax'
  -- use 'SidOfc/mkdx'
  -- use 'nelstrom/vim-markdown-folding'
  -- use 'dkarter/bullets.vim'
  use 'nvim-neorg/neorg'

  -- Text Objects / Pairs
  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-syntax'
  use 'andymass/vim-matchup'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-ragtag'

  -- StatusLine
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-lua/lsp-status.nvim'

  -- UI Affordances
  use 'mg979/vim-visual-multi'
  use 'triglav/vim-visual-increment'
  use 'machakann/vim-swap'
  use 'mbbill/undotree'
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
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-git'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-rsi'
  use 'mattn/calendar-vim'
  use 'whiteinge/diffconflicts'
  use 'tommcdo/vim-exchange'

  use 'stevearc/dressing.nvim'

  -- Colorscheme
  use 'arcticicestudio/nord-vim'

  -- Frontend
  use 'mattn/emmet-vim'

  -- Elixir
  -- use 'elixir-editors/vim-elixir'
  -- use 'andyl/vim-textobj-elixir'

  -- Tmux
  use 'christoomey/vim-tmux-navigator'
  use 'jgdavey/tslime.vim'
  use 'tpope/vim-tbone'
  use 'janko-m/vim-test'
  use 'tpope/vim-dispatch'
  use 'roxma/vim-tmux-clipboard'
end)

if packer_bootstrap then
  packer.sync()
end
