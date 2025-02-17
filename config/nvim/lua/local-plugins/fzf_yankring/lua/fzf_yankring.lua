local fzf_lua = require("fzf-lua")
local utils = require("fzf-lua.utils")
local history = require("yanky.history")

local regtype_to_text = function(regtype)
  if "v" == regtype then
    return "c"
  end

  if "V" == regtype then
    return "l"
  end

  return "b"
end

local M = {
  config = {}
}

M.setup = function(user_config)
  M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
end

M.yanks = function()
  local all_history = history.all()
  local entries = {}

  local find_yank_from_entry = function(entry)
    local numeric_part = tonumber(entry:match("^(%d+)"))
    return all_history[numeric_part]
  end

  for idx, item in pairs(all_history) do
    local first_line = vim.split(item.regcontents, "\n")[1]
    table.insert(entries,
      string.format(
        "%4s %s",
        utils.ansi_codes.red(tostring(idx)),
        first_line
      )
    )
  end

  return fzf_lua.fzf_exec(entries, {
    actions = {
      ["default"] = function(selected)
        local item = find_yank_from_entry(selected[1])
        local insertion_type = regtype_to_text(item.regtype)
        vim.api.nvim_put(vim.split(item.regcontents, "\n"), insertion_type, true, false)
      end
    },
    fzf_opts = {
      ['--preview'] = function(selected)
        local item = find_yank_from_entry(selected[1])
        return { item.regcontents }
      end,
    }
  })
end


return M
