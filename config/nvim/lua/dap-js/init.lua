local dap = require("dap")
local api = vim.api
local uv = vim.loop

local M = {}
local sessions = {}

M.widgets = {}
-- TODO: make it hierarchical instead of flat list
M.widgets.sessions = {
  refresh_listener = "event_initialized",
  new_buf = function()
    local buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(buf, "buftype", "nofile")
    api.nvim_buf_set_keymap(buf, "n", "<CR>", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
    api.nvim_buf_set_keymap(buf, "n", "<2-LeftMouse>", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
    return buf
  end,
  render = function(view)
    local layer = view.layer()
    local render_session = function(session)
      local suffix
      if session.current_frame then
        suffix = "Stopped at line " .. session.current_frame.line
      elseif session.stopped_thread_id then
        suffix = "Stopped"
      else
        suffix = "Running"
      end
      local prefix = session == dap.session() and "→ " or "  "
      return prefix .. (session.config.name or "No name") .. " (" .. suffix .. ")"
    end
    local context = {}
    context.actions = {
      {
        label = "Activate session",
        fn = function(_, session)
          if session then
            require("dap").set_session(session)
            if vim.bo.bufhidden == "wipe" then
              view.close()
            else
              view.refresh()
            end
          end
        end,
      },
    }
    layer.render(vim.tbl_keys(sessions), render_session, context)
  end,
}
function M.sidebar()
  require("dap.ui.widgets").sidebar(M.widgets.sessions).open()
end

function M.ultest(cmd)
  -- https://github.com/microsoft/vscode-js-debug/issues/214#issuecomment-572686921
  return {
    dap = {
      name = "Debug Jest Tests",
      type = "pwa-node",
      request = "launch",
      runtimeArgs = cmd,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end

local onexit_root_session = nil
local root_session = nil
dap.listeners.after["event_initialized"]["dap-js"] = function(session)
  if not root_session then
    root_session = session
  end
end

dap.listeners.after["event_terminated"]["dap-js"] = function(session)
  if session == root_session then
    onexit_root_session()
  end
end

function M.connect(callback)
  local stdin = uv.new_pipe(false)
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local handle, pid_or_err

  if onexit_root_session ~= nil then
    onexit_root_session()
  end
  onexit_root_session = function()
    stdin:close()
    stdout:close()
    stderr:close()
    handle:close()
    handle:kill(9)
    onexit_root_session = nil
  end

  handle, pid_or_err = uv.spawn("node", {
    args = {
      os.getenv("HOME") .. "/.local/share/nvim/dap/vscode-js-debug/out/src/vsDebugServer.js",
    },
    stdio = { stdin, stdout, stderr },
    detached = true,
  }, function()
    onexit_root_session()
  end)
  assert(handle, "Error trying to get DAP pid: " .. pid_or_err)

  stdout:read_start(function(_, chunk)
    local port = chunk:gsub("\n", "")
    vim.schedule(function()
      callback({
        type = "server",
        host = "127.0.0.1",
        port = port,
        reverse_request_handlers = {
          attachedChildSession = function(_, request)
            local body = request.arguments
            local session = require("dap.session"):connect(
              { host = "127.0.0.1", port = tonumber(body.config.__jsDebugChildServer) },
              {},
              function(err)
                if err then
                  vim.notify("DAP connection failed to start:" .. err, "error")
                end
              end
            )
            session:initialize(body.config)
            dap.set_session(session)
            sessions[session] = true
          end,
        },
      })
    end)
  end)
end

return M
