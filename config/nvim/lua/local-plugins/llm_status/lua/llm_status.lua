local M = {}

local spinner_symbols = {
  "⠋",
  "⠙",
  "⠹",
  "⠸",
  "⠼",
  "⠴",
  "⠦",
  "⠧",
  "⠇",
  "⠏",
}

local think_icon = "󱚟"

M.timer = nil

function M:notify_spinner_start()
  local index = 1

  self.timer = vim.uv.new_timer()
  self.timer:start(0, 100, vim.schedule_wrap(function()
    vim.notify(
      spinner_symbols[index],
      vim.log.levels.INFO,
      { title = "Companion thinking", id = "llm_progress", icon = think_icon }
    )
    index = (index % #spinner_symbols) + 1
  end))
end

function M:notify_spinner_stop()
  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end
end

-- Initializer
function M:setup()
  local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        M.notify_spinner_start(M)
      elseif request.match == "CodeCompanionRequestFinished" then
        M.notify_spinner_stop(M)
      end
    end,
  })
end

return M
