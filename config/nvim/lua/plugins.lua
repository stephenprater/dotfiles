local ensure_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

packer.init {
  max_jobs = 5,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end
  }
}

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

  use({ 'utilyre/barbecue.nvim',
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    after = {
      "nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({
        symbols = {
          separator = ""
        },
        kinds = {
          File = "",
          Module = "",
          Namespace = "",
          Package = "",
          Class = "",
          Method = "",
          Property = "",
          Field = "",
          Constructor = "",
          Enum = "練",
          Interface = "練",
          Function = "",
          Variable = "",
          Constant = "",
          String = "",
          Number = "",
          Boolean = "◩",
          Array = "",
          Object = "",
          Key = "",
          Null = "ﳠ",
          EnumMember = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
          Macro = "",
        },
        theme = {
          separator = { fg = "#63849c" },
          normal = { fg = "#afafaf", bg = "#161616" },
        }
      })
    end,
  })

  use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
  use { 'RRethy/nvim-treesitter-textsubjects', requires = 'nvim-treesitter' }
  use { 'RRethy/nvim-treesitter-endwise', requires = 'nvim-treesitter' }
  use { 'nvim-treesitter/playground', requires = 'nvim-treesitter' }
  use { 'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter' }

  use({'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.formatting.stylua,
          require("typescript.extensions.null-ls.code-actions"),
        },
      })
    end
    })

  use({'jose-elias-alvarez/typescript.nvim',
      config = function()
        require('typescript').setup({
          disable_commands = true
        })
      end
    })

  -- Debugger
  use 'ziontee113/syntax-tree-surfer'
  use { 'stephenprater/iron.nvim', branch = "attach-and-no-deprecation" }
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'rcarriga/nvim-dap-ui'

  -- Autocomplete
  use 'jbyuki/one-small-step-for-vimkind'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'

  -- Snippets
  use 'github/copilot.vim'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- FZF
  use 'rafamadriz/friendly-snippets'
  use { 'junegunn/fzf', run = ':call fzf#install(})' }
  use 'junegunn/fzf.vim'
  use 'gfanto/fzf-lsp.nvim'

  -- RG

  -- File Navigation
  use 'jremmen/vim-ripgrep'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons'
  }


  use 'tpope/vim-projectionist'

  -- YankRing
  use 'bfredl/nvim-miniyank'

  -- Neorg
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
  use({ "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      require("which-key").setup {}
    end
  })

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

  use({ 'stevearc/dressing.nvim',
    config = function()
      local dressing = require("dressing")
      dressing.setup({
        select = {
          backend = { "fzf", "fzf_lua", "telescope", "builtin", "nui" }
        }
      })
    end
  })

  use({ 'rcarriga/nvim-notify',
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#161616",
      })
      vim.notify = notify
    end,
  })

  use 'lukas-reineke/indent-blankline.nvim'

  -- Colorscheme
  use 'arcticicestudio/nord-vim'
  use({ 'ziontee113/color-picker.nvim',
    config = function()
      require("color-picker").setup({
        border = "rounded"
      })

      vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-c>", "<cmd>PickColorInsert<CR>", { noremap = true, silent = true })
    end,
  })

  use({ "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })

      vim.keymap.set("n", "<C-e>", "<cmd>IconPickerNormal<CR>", { noremap = true, silent = true })
    end,
  })

  -- Frontend
  use 'mattn/emmet-vim'
  use 'prisma/vim-prisma'

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
