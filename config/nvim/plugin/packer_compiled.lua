-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/stephenprater/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/stephenprater/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/stephenprater/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/stephenprater/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/stephenprater/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["bullets.vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/bullets.vim",
    url = "https://github.com/dkarter/bullets.vim"
  },
  ["calendar-vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/calendar-vim",
    url = "https://github.com/mattn/calendar-vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  diffconflicts = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/diffconflicts",
    url = "https://github.com/whiteinge/diffconflicts"
  },
  fzf = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf-lsp.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/fzf-lsp.nvim",
    url = "https://github.com/gfanto/fzf-lsp.nvim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["iron.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/iron.nvim",
    url = "https://github.com/Vigemus/iron.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  mkdx = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/mkdx",
    url = "https://github.com/SidOfc/mkdx"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nord-vim",
    url = "https://github.com/arcticicestudio/nord-vim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-fzf"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-fzf",
    url = "https://github.com/vijaymarupudi/nvim-fzf"
  },
  ["nvim-fzf-commands"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-fzf-commands",
    url = "https://github.com/vijaymarupudi/nvim-fzf-commands"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-miniyank"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-miniyank",
    url = "https://github.com/bfredl/nvim-miniyank"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/one-small-step-for-vimkind",
    url = "https://github.com/jbyuki/one-small-step-for-vimkind"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  tabular = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  tagbar = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/tagbar",
    url = "https://github.com/majutsushi/tagbar"
  },
  ["tslime.vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/tslime.vim",
    url = "https://github.com/jgdavey/tslime.vim"
  },
  ultisnips = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  ["utl.vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/utl.vim",
    url = "https://github.com/vim-scripts/utl.vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-bufonly"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-bufonly",
    url = "https://github.com/duff/vim-bufonly"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-elixir"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-elixir",
    url = "https://github.com/elixir-editors/vim-elixir"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-exchange",
    url = "https://github.com/tommcdo/vim-exchange"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gfm-syntax"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-gfm-syntax",
    url = "https://github.com/rhysd/vim-gfm-syntax"
  },
  ["vim-git"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-git",
    url = "https://github.com/tpope/vim-git"
  },
  ["vim-markdown-folding"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-markdown-folding",
    url = "https://github.com/nelstrom/vim-markdown-folding"
  },
  ["vim-markology"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-markology",
    url = "https://github.com/jeetsukumaran/vim-markology"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  },
  ["vim-mundo"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-mundo",
    url = "https://github.com/simnalamburt/vim-mundo"
  },
  ["vim-ninja-feet"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-ninja-feet",
    url = "https://github.com/tommcdo/vim-ninja-feet"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-ragtag"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-ragtag",
    url = "https://github.com/tpope/vim-ragtag"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-ripgrep"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-ripgrep",
    url = "https://github.com/jremmen/vim-ripgrep"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-rsi",
    url = "https://github.com/tpope/vim-rsi"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-speeddating",
    url = "https://github.com/tpope/vim-speeddating"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-swap"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-swap",
    url = "https://github.com/machakann/vim-swap"
  },
  ["vim-tbone"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-tbone",
    url = "https://github.com/tpope/vim-tbone"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/janko-m/vim-test"
  },
  ["vim-textobj-elixir"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-textobj-elixir",
    url = "https://github.com/andyl/vim-textobj-elixir"
  },
  ["vim-textobj-syntax"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-textobj-syntax",
    url = "https://github.com/kana/vim-textobj-syntax"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-tmux-clipboard"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-tmux-clipboard",
    url = "https://github.com/roxma/vim-tmux-clipboard"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
