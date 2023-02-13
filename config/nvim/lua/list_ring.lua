local M = {}
local api = vim.api

local Ring = {}

function Ring.new (inter)
  local self = { length = 0 }
  setmetatable(self, { __index = Ring })
  for _,v in ipairs(inter) do self:push(v) end
  return self
end

function Ring:push(t)
  local element = { value = t }

  if self.last then
    local prev = self.last
    self.last._next = element
    self.last = element
    element._next = self.first
    element._prev = prev
  else
    self.first = element
    self.last = element
  end

  self.length = self.length + 1
end

function Ring:forward()
  local current = nil

  return function()
    if not current then
        current = self.first
    else
        current = current._next
    end

    return current.value
  end
end

function Ring:backward()
  local current = nil

  return function()
    if not current then
      current = self.first
    else
      current = current._prev
    end

    return current.value
  end
end

local lists = Ring.new({
  {
    name = "buffers",
    cmd = "FzfLua",
  },
  {
    name ="oldfiles",
    cmd = "FzfLua",
  },
  {
    name = "files",
    cmd = "FzfLua",
  },
  {
    name = "live_grep",
    cmd = "FzfLua",
  },
  {
    name = "lsp_workplace_symbols",
    cmd = "FzfLua",
    cond = function()
      local cap = vim.lsp.get_active_clients()[1].server_capabilities
      if cap and cap["workspaceSymbolProvder"] then
        return true
      else
        return false
      end
    end
  }
})

local forward_iter = lists:forward()
local backward_iter = lists:forward()

M.next_list = function()
  M.iterate(forward_iter)
end

M.prev_list = function ()
  M.iterate(backward_iter)
end

M.iterate = function (iterator)
 local success = false
  local fail_count = 0
  repeat
    success = pcall(M.display_list, iterator())
    if not success then
      fail_count = fail_count + 1
    end
  until success or fail_count > 5
end

M.display_list = function(list)
  if not list.cond or (list.cond and list.cond()) then
    api.nvim_cmd({ cmd = list.cmd, args = {list.name}}, {})
  else
    vim.notify(list.cmd .. " is not supported", vim.log.levels.WARN)
    error(list.cmd .. " is not supported")
  end
end

M.start_list_cycle = function()
  forward_iter = lists:forward()
  backward_iter = lists:forward()

  M.next_list()
end

return M
