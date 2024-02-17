local M = {}

local client_notifs = {}

local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
  local notif_data = client_notifs[client_id][token]
  if notif_data and notif_data.spinner then
    local new_spinner = (notif_data.spinner + 1) % #spinner_frames
    local new_notif = vim.notify(
      nil,
      nil,
      { hide_from_history = true, icon = spinner_frames[new_spinner], replace = notif_data.notification }
    )
    client_notifs[client_id][token] = {
      notification = new_notif,
      spinner = new_spinner,
    }
    vim.defer_fn(function()
      update_spinner(client_id, token)
    end, 100)
  end
end

local function format_title(title, client)
  return client.name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
  return (percentage and percentage .. "%\t" or "") .. (message or "")
end

function right_justify_lines(lines, max_width)
    local output_lines = {}
    for _, line in ipairs(lines) do
      local current = 0
      local line_length = #line
      local target = math.min(line_length + 1, max_width)

      if line_length < target then -- just insert the line if it's short enough
        table.insert(output_lines, line)
      else
        local output_line = ""
        -- otherwise add the words one by one, inserting a line
        -- each time the current line length exceeds the target
        for word in string.gmatch(line, "%w+") do
          local word_length = #word
          if current + word_length > target then
            table.insert(output_lines, output_line)
            output_line = ""
            current = 0
          else
            output_line = output_line .. word .. " "
            current = current + word_length + 1
          end
        end

        table.insert(output_lines, output_line)
      end
    end
    return output_lines
end

function add_prefix_to_lines(lines, prefix)
    local prefix_length = #prefix
    local spaces = string.rep(' ', prefix_length)
    for i, line in ipairs(lines) do
        if i == 1 then
            lines[i] = prefix .. " " .. line
        else
            lines[i] = spaces .. " " .. line
        end
    end
    return lines
end

local function table_concat(t1, t2)
  local t = {}
  for _, v in ipairs(t1) do
    table.insert(t, v)
  end
  for _, v in ipairs(t2) do
    table.insert(t, v)
  end
  return t
end

M.render = function(bufnr, notif, highlights, config)
  local namespace = require("notify.render.base").namespace()
  local icon = notif.icon
  local title = notif.title[1]
  local prefix
  local message = {}
  local notification_message = table.concat(notif.message, "\n")

  local default_titles = { "Error", "Warning", "Notify" }
  local has_valid_manual_title = type(title) == "string"
    and #title > 0
    and not vim.tbl_contains(default_titles, title)

  if has_valid_manual_title then
    -- has title = icon + title
    prefix = string.format("%s %s", icon, title)
  else
    -- no title = prefix the icon
    prefix = string.format("%s", icon)
  end

  local max_width = config.max_width()
  if max_width == nil then
    max_width = 80
  end

  local justified_message = right_justify_lines(notif.message, max_width)
  local prefixed_message = add_prefix_to_lines(justified_message, prefix)

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, prefixed_message)

  local icon_length = vim.str_utfindex(icon)
  local prefix_length = vim.str_utfindex(prefix) + 1

  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    hl_group = highlights.icon,
    end_col = icon_length + 1,
    priority = 50,
  })
  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, icon_length + 1, {
    hl_group = highlights.title,
    end_col = prefix_length + 1,
    priority = 50,
  })
  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, prefix_length + 1, {
    hl_group = highlights.body,
    end_line = #message,
    priority = 50,
  })
end

M.handler = function(_, result, ctx)
  local client_id = ctx.client_id
  local val = result.value
  if val.kind then
    if not client_notifs[client_id] then
      client_notifs[client_id] = {}
    end
    local notif_data = client_notifs[client_id][result.token]
    if val.kind == "begin" then
      local message = format_message(val.message, val.percentage)
      local notification = vim.notify(message, "info", {
        title = format_title(val.title, vim.lsp.get_client_by_id(client_id)),
        icon = spinner_frames[1],
        timeout = false,
        hide_from_history = true
      })
      client_notifs[client_id][result.token] = {
        notification = notification,
        spinner = 1,
      }
      update_spinner(client_id, result.token)
    elseif val.kind == "report" and notif_data then
      local new_notif = vim.notify(
        format_message(val.message, val.percentage),
        "info",
        { replace = notif_data.notification, hide_from_history = false }
      )
      client_notifs[client_id][result.token] = {
        notification = new_notif,
        spinner = notif_data.spinner,
      }
    elseif val.kind == "end" and notif_data then
      local new_notif = vim.notify(
        val.message and format_message(val.message) or "Complete",
        "info",
        { icon = "", replace = notif_data.notification, timeout = 3000 }
      )
      client_notifs[client_id][result.token] = {
        notification = new_notif,
      }
    end
  end
end

local stages_util = require("notify.stages.util")

M.stages = function(direction)
  return {
    function(state)
      local next_height = state.message.height + 2
      local next_row = stages_util.available_slot(state.open_windows, next_height, direction)
      if not next_row then
        return nil
      end
      return {
        relative = "editor",
        anchor = "NE",
        width = state.message.width,
        height = state.message.height,
        col = vim.opt.columns:get(),
        row = next_row,
        border = "none",
        style = "minimal",
      }
    end,
    function(state, win)
      return {
        col = vim.opt.columns:get(),
        time = true,
        row = stages_util.slot_after_previous(win, state.open_windows, direction),
      }
    end,
  }
end

return M
