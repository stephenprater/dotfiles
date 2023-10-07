local M = {}

local function fzf_miniyank(put_before, fullscreen)
  local function LocalSink(opt, line)
    local key = string.gsub(line, ' .*', '')
    if #line == 0 then return end
    local yanks = require('miniyank').read()[key]
    require('miniyank').drop(yanks, opt)
  end

  local put_action = put_before and 'P' or 'p'
  local name = put_before and 'YanksBefore' or 'YanksAfter'
  local spec = {}
  spec['source'] = vim.tbl_map(function(v)
    return tostring(v) .. ' ' .. table.concat(v[1], '\n')
  end, require('miniyank').read())
  spec['sink'] = function(val) LocalSink(put_action, val) end
  spec['options'] = '--no-sort --prompt="Yanks-' .. put_action .. '> "'
  require('fzf').run(require('fzf').wrap(name, spec, fullscreen))
end

M.setup = function()
	vim.api.nvim_create_user_command('YanksBefore', function(opts)
		fzf_miniyank(1, opts.bange)
	end, { bang = true })

	vim.api.nvim_create_user_command('YanksAfter', function(opts)
		fzf_miniyank(0, opts.bange)
	end, { bang = true })

	vim.keymap.set('n', ',yr', ':YanksBefore<CR>')
end

return M
