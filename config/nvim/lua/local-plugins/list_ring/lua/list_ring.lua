local M = {}

local Ring = {}

function Ring.new(inter)
	local self = { length = 0 }
	setmetatable(self, { __index = Ring })
	for _, v in ipairs(inter) do
		self:push(v)
	end
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

M.setup = function(config)
	local lists = {}

	if config then
		lists = Ring.new(config.lists)
	end

	lists.next_list = function()
		lists.iterate(lists.forward_iter)
	end

	lists.prev_list = function()
		lists.iterate(lists.backward_iter)
	end

	lists.iterate = function(iterator)
		local success = false
		local msg
		local fail_count = 0
		repeat
			success, msg = pcall(lists.display_list, iterator())
			if not success then
				vim.notify(msg or "Something bad happened.")
				fail_count = fail_count + 1
			end
		until success or fail_count > 5
	end

	lists.display_list = function(list)
		for _, win in pairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			if vim.b[buf]["fzf"] then
				vim.api.nvim_win_close(win, true)
			end
		end

		vim.api.nvim_cmd({ cmd = "sleep", args = { tostring(vim.o.timeoutlen / 2) .. "m" } }, {})

		if not list.cond or (list.cond and list.cond()) then
			if list.args then
				vim.api.nvim_cmd({ cmd = list.cmd, args = list.args }, {})
			else
				vim.api.nvim_cmd({ cmd = list.cmd, args = { list.name } }, {})
			end
		else
			vim.notify(list.cmd .. " is not supported", vim.log.levels.WARN)
			error(list.cmd .. " is not supported")
		end
	end

	lists.start_list_cycle = function()
		lists.forward_iter = lists:forward()
		lists.backward_iter = lists:backward()

		lists.next_list()
	end

	lists.vim_enable_next_list = function(buf)
		-- local key = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)

		vim.keymap.set("t", "<C-p>", function()
			lists.next_list()
		end, { noremap = true, silent = true, buffer = buf })

		vim.keymap.set("t", "<C-n>", function()
			lists.prev_list()
		end, { noremap = true, silent = true, buffer = buf })

		vim.keymap.set("t", "<Esc>", '<Esc>', { buffer = buf })
	end

	vim.api.nvim_create_autocmd({ "Filetype" }, {
		pattern = "fzf",
		callback = function(ev)
			lists.vim_enable_next_list(ev.buf)
		end,
	})

	vim.keymap.set("n", "<C-p>", function()
		lists.start_list_cycle()
	end, { noremap = true, silent = true })
end

return M
