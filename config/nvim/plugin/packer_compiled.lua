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
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/bullets.vim"
  },
  ["calendar-vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/calendar-vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  diffconflicts = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/diffconflicts"
  },
  fzf = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf-lsp.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/fzf-lsp.nvim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["iron.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/iron.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  mkdx = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/mkdx"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nord-vim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-fzf"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-fzf"
  },
  ["nvim-fzf-commands"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-fzf-commands"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-miniyank"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-miniyank"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/one-small-step-for-vimkind"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  tabular = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/tabular"
  },
  tagbar = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/tagbar"
  },
  ["tslime.vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/tslime.vim"
  },
  ultisnips = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["utl.vim"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/utl.vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-bufonly"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-bufonly"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-exchange"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gfm-syntax"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-gfm-syntax"
  },
  ["vim-git"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-git"
  },
  ["vim-markdown-folding"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-markdown-folding"
  },
  ["vim-markology"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-markology"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors"
  },
  ["vim-mundo"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-mundo"
  },
  ["vim-ninja-feet"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-ninja-feet"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-ragtag"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-ragtag"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-ripgrep"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-ripgrep"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-rsi"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-speeddating"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-swap"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-swap"
  },
  ["vim-tbone"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-tbone"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-textobj-syntax"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-textobj-syntax"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-tmux-clipboard"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-tmux-clipboard"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/stephenprater/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
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
