local M = {}

M.close_floating_windows = function()
  local closed_windows = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then     -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
      table.insert(closed_windows, win)
    end
  end
  print(string.format("Closed %d windows: %s", #closed_windows, vim.inspect(closed_windows)))
end

M.fzf_files = function()
  require("fzf-commands").files({
    fzf = function(contents, options)
      vim.cmd("20split")
      return require("fzf").provided_win_fzf(contents, options)
    end,
  })
end

M.replace_motion = function(type)
  local sel_save = vim.o.selection
  vim.o.selection = "inclusive"
  local reg_save = vim.fn.getreg("0")

  if type ~= nil then -- Invoked from Visual mode, use gv command.
    vim.cmd("normal! r0")
  elseif type == "line" then
    vim.cmd("normal! `[V`]c0")
  else
    vim.cmd("normal! `[v`]c0")
  end

  vim.o.selection = sel_save
  vim.fn.setreg("0", reg_save)
end

M.toggle_relative_numbers = function()
  local rel_numbers = vim.wo.relativenumber
  if rel_numbers then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end

M.get_region = function(start_mark, end_mark)
  local lnum1, col1 = unpack(vim.fn.getpos(start_mark), 2)
  local lnum2, col2 = unpack(vim.fn.getpos(end_mark), 2)
  local lines = vim.fn.getline(lnum1, lnum2)
  lines[#lines] = string.sub(lines[#lines], 1, col2 - 1)
  lines[1] = string.sub(lines[1], col1)
  return lines
end

M.ripgrep_visual = function()
  local old_r = vim.fn.getreg("r")
  vim.fn.setreg("r", M.get_region("'<", "'>")[1])
  vim.cmd("silent Rg " .. vim.fn.getreg("r"))
  vim.fn.setreg("r", old_r)
end

M.luadev_run_operator = function(is_op)
  local lnum1, col1 = unpack(vim.fn.getpos(is_op and "'<" or "'["), 2)
  local lnum2, col2 = unpack(vim.fn.getpos(is_op and "'>" or "']"), 2)

  if lnum1 > lnum2 then
    lnum1, col1, lnum2, col2 = lnum2, col2, lnum1, col1
  end

  local lines = vim.fn.getline(lnum1, lnum2)
  if is_op or lnum1 == lnum2 then
    lines[#lines] = string.sub(lines[#lines], 1, col2 - (vim.o.selection == "inclusive" and 1 or 2))
    lines[1] = string.sub(lines[1], col1)
  end

  if type(lines) ~= "table" then
    lines = { lines }
  end

  local joined_lines = table.concat(lines, "\n") .. "\n"
  require("luadev").exec(joined_lines)
end

M.highlight_group = function()
  local syndict = {}
  syndict["highlight"] = vim.fn.synIDattr(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1), "name")
  syndict["trans"] = vim.fn.synIDattr(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 0), "name")
  syndict["lolight"] = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)), "name")
  syndict["fg_col"] = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)), "fg#")
  print(vim.inspect(syndict))
end

M.synstack = function()
  if not vim.fn.exists("*synstack") then
    return
  end
  print(vim.inspect(vim.tbl_map(function(val)
    return vim.fn.synIDattr(val, "name")
  end, vim.fn.synstack(vim.fn.line("."), vim.fn.col(".")))))
end

M.shopify_proxy_key = function()
  if vim.fn.executable("openai_key") == 1 then
    -- make this async
    vim.fn.system("openai_key")
  else
    vim.notify("Who are you? You're not running this in Prater's dotfiles.", vim.log.levels.ERROR)
    return
  end

  local file = io.open(os.getenv("HOME") .. "/.oai-proxy-details", "r")
  if not file then
    vim.notify("No proxy details found.", vim.log.levels.ERROR)
    return
  end

  local data = file:read("*a")
  file:close()
  local proxy_info = vim.fn.json_decode(data)
  return proxy_info
end

return M
