local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return {
	-- Show the current location in the winbar.
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
    opts = {
				symbols = {
					separator = "",
				},
				kinds = {
					File = "",
					Module = "",
					Namespace = "",
					Package = "",
					Class = "",
					Method = "",
					Property = "",
					Field = "",
					Constructor = "",
					Enum = "練",
					Interface = "練",
					Function = "",
					Variable = "",
					Constant = "",
					String = "",
					Number = "",
					Boolean = "◩",
					Array = "",
					Object = "",
					Key = "",
					Null = "ﳠ",
					EnumMember = "",
					Struct = "",
					Event = "",
					Operator = "",
					TypeParameter = "",
					Macro = "",
				},
				theme = {
					separator = { fg = "#63849c" },
					normal = { fg = "#afafaf", bg = "#1f1f28" },
				},
			}
	},
  -- {
  --   "SmiteshP/nvim-navic",
  --   opts = {
  --     separator = "  ",
  --     lsp = {
  --       auto_attach = true,
  --     },
  --     highlight = true,
  --   },
  -- },
	-- -- Status line written in Lua
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"folke/noice.nvim",
		},
		config = function()
			local custom_nord = require("lualine.themes.nord")
			custom_nord.normal.c.bg = "#1f1f28"
			custom_nord.normal.b.bg = "#1f1f28"
			custom_nord.normal.a.bg = "#1f1f28"

			-- local lsp_status = require("lsp-status")

			local noice = function()
				if require("noice").api.status.mode.has then
					local status = require("noice").api.status.mode.get()
					local start, stop = status:find("recording ..")
					if start ~= nil then
						local add = status:sub(start, stop)
						local with_symbol = add:gsub("recording", "󰻂")
						return "%#Error#" .. with_symbol
					end
				end

				return ""
			end

			require("lualine").setup({
				options = { theme = custom_nord },
				sections = {
					lualine_a = {
						"mode",
						noice,
					},
				},
        -- inactive_winbar = {
        --   lualine_c = {
        --     "filename",
        --   }
        -- },
        -- winbar = {
        --   lualine_c = {
        --     'navic',
        --     color_correction = nil,
        --     navic_opts = nil
        --   }
        -- },
			})
		end,
	},

	-- Show available keystrokes
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			local wk = require("which-key")

			wk.setup({
				preset = "modern",
				delay = function(ctx)
					return ctx.plugin and 0 or 500
				end,
			})

			wk.add({
				{ "<Esc><Esc", ":nohls<CR>", hidden = true },
				{ ",", group = "navigate" },
        { "//", group = "Local Actions" },
        { "//t", group = "Todos" },
        { "//i", group = "Images" },
        { ",a", group = "Code Companion" },
        { ",ac", ":CodeCompanionChat<CR>", desc = "Open Code Companion Chat" },
        { "/a", ":CodeCompanionChat Add<CR>", desc = "Open Code Companion Chat Selection", mode = "v"},
        { ",al", ":CodeCompanionActions<CR>", desc = "Code Companions Actions" },
        { ",ae", ":CodeCompanion<CR>", desc = "Code Companion Popup" },
				{ ",b", ":FzfLua buffers<CR>", desc = "Show Buffers" },
				{ ",cn", ":cn<CR>", desc = "Next Quickfix" },
				{ ",cp", ":cp<CR>", desc = "Previous Quickfix" },
				{ ",f", ":FzfLua files<CR>", desc = "Show Files" },
				{ ",/", ":FzfLua live_grep<CR>", desc = "Show Project Search" },
				{ ",s", ":FzfLua lsp_workplace_symbols<CR>", desc = "Show DocumentSymbols" },
				{ ",m", ":FzfLua marks<CR>", desc = "Choose Mark" },
        { "<F1>", ":FzfLua<CR>", desc = "Search All" },
				{ ",n", group = "neotest" },
				{ ",no", ":Neotest output-panel<CR>", desc = "Neotest Output" },
				{ ",ns", ":Neotest summary<CR>", desc = "Neotest Summary" },
				{ ",g", ":Git<CR>", desc = "Show Fugitive" },
				{
					",p",
					function()
						local preview_open = require("peek").is_open()
						if preview_open then
							require("peek").close()
						else
							require("peek").open()
						end
					end,
					desc = "Markdown Preview",
				},
				{
					",q",
					":History:<CR>",
					desc = "Show Command History",
				},
				{ ",r", ":FzfLua oldfiles<CR>", desc = "Show History" },
				{ ",t", ":AerialToggle right<CR>", desc = "Show Tagbar" },
				{ ",u", ":UndotreeToggle<CR>", desc = "Show Undotree" },
				{
					",x",
					":NvimTreeToggle<CR>",
					desc = "Toggle NvimTree",
				},
				{ ",X", ":vsplit | wincmd h | vertical resize 50 | execute 'Oil'<CR>", desc = "Open Oil" },
				{ ";", ":HopWord<CR>", desc = "Hop Word" },
				{ "<leader>", group = "quick commands" },
				{ "<leader>T", ":TestFile<CR>", desc = "Test File" },
				{ "<leader>t", ":TestNearest<CR>", desc = "Test Nearest" },
				{ "<leader>r", ":Other<CR>", desc = "Other File" },
				{
					"<leader>A",
					":Rg<CR>",
					noremap = true,
					silent = true,
					mode = "n",
					desc = "RipGrep",
				},
				{
					"<leader>A",
					function()
						require("functions").rg_vis()
					end,
					noremap = true,
					silent = true,
					mode = "v",
					desc = "RipGrep Visual Selection",
				},
				{ "<leader><leader>", group = "Tools" },
				{ "<leader><leader>bc", ":silent . !bc<CR>", desc = "Calculate" },
				{ "<leader><leader>da", ":.!date<CR>", desc = "Today's Date" },
				{ "<leader><leader>l", ":Neorg workspace log<CR>", desc = "Log" },
				{ "<leader>d", group = "Debugger" },
				{ "<leader>d<F5>", ":lua require('osv').launch({port=8086})<CR>", desc = "Connect to Lua" },
				{ "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
				{ "<leader>dc", ":lua require('dap').continue()<CR>", desc = "Continue" },
				{ "<leader>df", ":lua require('dap').step_out()<CR>", desc = "Step Out" },
				{ "<leader>di", ":lua require('dap').step_into()<CR>", desc = "Step Into" },
				{ "<leader>dn", ":lua require('dap').step_over()<CR>", desc = "Step Over" },
				{ "<leader>du", ":lua require('dapui').toggle({})<CR>", desc = "Toggle DAP UI" },
				{
					"<leader>dw",
					function()
						local watch = vim.fn.input("Watch Expression: ")
						return ":lua require('dap').watches.add(" .. watch .. ")<CR>"
					end,
					desc = "Add Watch",
					expr = true,
					replace_keycodes = false,
				},
				{ "<leader>g", group = "Git" },
				{ "<leader>gU", ":lua require('gitsigns').reset_buffer()<CR>", desc = "Reset Buffer" },
				{ "<leader>ga", ":lua require('gitsigns').stage_hunk()<CR>", desc = "Stage Hunk" },
				{ "<leader>gb", ":lua require('gitsigns').blame_line()<CR>", desc = "Blame Line" },
				{ "<leader>gd", ":lua require('gitsigns').toggle_deleted()<CR>", desc = "Toggle Deleted" },
				{
					"<leader>gl",
					":lua require('gitsigns').toggle_current_line_blame()<CR>",
					desc = "Toggle Line Blame",
				},
				{ "<leader>gp", ":lua require('gitsigns').preview_hunk()<CR>", desc = "Preview Hunk" },
				{ "<leader>gr", ":lua require('gitsigns').reset_hunk()<CR>", desc = "Reset Hunk" },
				{ "<leader>gs", ":lua require('gitsigns').select_hunk()<CR>", desc = "Select Hunk" },
				{ "<leader>gu", ":lua require('gitsigns').undo_stage_hunk()<CR>", desc = "Undo Stage Hunk" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>l?", ":lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help" },
				{ "<leader>l]", ":References<CR>", desc = "Show References" },
				{ "<leader>la", ":CodeActions<CR>", desc = "Code Actions" },
				{ "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", desc = "Goto Definition" },
				{ "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
				{ "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
				{ "<leader>ls", ":lua vim.lsp.buf.document_symbol()<CR>", desc = "Open Document Symbols" },
				{ "<leader>lx", ":lua vim.diagnostic.open_float()<CR>", desc = "Open Diagnostic Float" },
				{
					"<leader>ly",
					function()
						local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
						local diags = vim.diagnostic.get(0, { lnum = row - 1 })
						if #diags > 0 then
							local messages = ""
							for idx, diag in ipairs(diags) do
								messages = messages .. string.format("%d: %s\n", idx, diag["message"])
							end
							vim.fn.setreg('"', messages)
						end
					end,
					desc = "Copy line diagnostic into unnamed register",
				},
				{ "<leader>n", group = "neotest" },
				{ "<leader>nT", ":w | lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Test File" },
				{ "<leader>nd", ":w | lua require('neotest').run.run({ strategy = 'dap' })<CR>", desc = "Debug Test" },
				{
					"<leader>nr",
					":lua require('neotest').output.open({ enter = true })<CR>",
					desc = "Open Results Windows",
				},
				{ "<leader>nt", ":w | lua require('neotest').run.run()<CR>", desc = "Test Nearest" },
				{ "]", group = "window" },
				{ "]'", "<C-W>+", desc = "Size Up" },
				{ "],", "<C-W><", desc = "Size Left" },
				{ "].", "<C-W>>", desc = "Size Right" },
				{ "]/", "<C-W>-", desc = "Size Down" },
				{ "]_", ":split<cr>", desc = "Horizontal Split" },
				{ "]h", "<C-W>h", desc = "Move Left" },
				{ "]j", "<C-W>", desc = "Move Down" },
				{ "]k", "<C-W>k", desc = "Move Up" },
				{ "]l", "<C-W>l", desc = "Move Right" },
				{ "]o", ":bn<cr>", desc = "Next Buffer" },
				{ "]p", ":bp<cr>", desc = "Previous Buffer" },
				{ "]{", ":tabprev<cr>", desc = "Previous Tab" },
				{ "]|", ":vsplit<cr>", desc = "Vertical Split" },
				{ "]}", ":tabnext<cr>", desc = "Next Tab" },
				{ "dm", ":execute 'delmarks '.nr2char(getchar())<cr>", desc = "Delete Mark" },
				{ "g<", ":ISwapNodeWithLeft<CR>", desc = "Swap Left" },
				{ "g>", ":ISwapNodeWithRight<CR>", desc = "Swap Right" },
				{ "gS", ":ISwap<CR>", desc = "Interactive Swap" },
				{ "gj", ":TSJJoin<CR>", desc = "Treesitter Join" },
				{ "gs", ":TSJSplit<CR>", desc = "Treesitter Split" },
			})
		end,
	},

	{ "MunifTanjim/nui.nvim" },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      { 'junegunn/fzf', build = ':call fzf#install(})' },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", { pattern = "LazyLoad", callback = function(event)
        if event.data == "fzf-lua" then
          require("fzf-lua").register_ui_select()
        end
      end })
    end,
    opts = {
      winopts = {
        split = "topleft 30 new",
      },
      fzf_opts = {
        ['--layout'] = "default",
      },
    },
  },

	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "ibhagwan/fzf-lua" },
		opts = {
			presets = {
				command_palette = false,
				lsp_doc_border = true,
				long_message_to_split = true,
			},
			cmdline = {
				view = "cmdline",
			},
			lsp = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					-- throttle = 1000 / 30,
					view = "mini",
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "echomsg",
						find = "Gp:",
					},
					view = "mini",
				},
        {
          filter = {
            event = "notify",
            cond = function(message)
              if(message.opts.id == "llm_progress") then
                return true
              else
                return false
              end
            end
          },
          view = "mini"
        },
				{
					-- show the digraph table in a popup
					filter = {
						event = "msg_show",
						find = "13SO",
					},
					view = "popup",
				},
				{
					filter = {
						event = "msg_show",
						kind = "echomsg",
					},
					view = "mini",
				},
				{
					filter = {
						event = "msg_show",
						kind = "echo",
					},
					view = "mini",
				},
				{
					filter = {
						event = "msg_show",
						kind = "echoerr",
					},
					view = "split",
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					view = "mini",
				},
			},
		},
	},

	-- Sneaky snake went dancing
  {
    "smoka7/hop.nvim",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    }
  },

	-- Multiple cursors
	"mg979/vim-visual-multi",

	-- Increment a each element in a visual selection
	"triglav/vim-visual-increment",

	-- Pretty UI
	{
		"stevearc/dressing.nvim",
    opts = {}
	},
  -- Ctrl-P like List Rotation
  {
    "list_ring",
    dev = true,
    opts = {
      lists = {
        {
          cmd = "FzfLua",
          args = { "buffers" }
        },
        {
          cmd = "FzfLua",
          args = { "oldfiles" }
        },
        {
          cmd = "FzfLua",
          args = { "files" }
        },
        {
          cmd = "FzfLua",
          args = { "live_grep" }
        },
        {
          args = { "lsp_live_workplace_symbols" },
          cmd = "FzfLua",
          cond = function()
            local cap = vim.lsp.buf_clients({ bufnr = vim.current.buffer }).server_capabilities
            if cap and cap["workspaceSymbolProvder"] then
              return true
            else
              return false
            end
          end,
        },
      },
    }

  },
	-- Popup Notifications
  {
    "folke/snacks.nvim",
    priorty = 1000,
    lazy = false,
    opts = {
      notifier = {
        top_down = false,
        enabled = true,
      },
      picker = {
        enabled = true,
      }
    }
  },

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
    cmd = "Trouble"
	},

	-- Adds indentation guides to blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "IblIndent", { fg = "#34342d" })
				vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#34342d" })
			end)

			require("ibl").setup({
				indent = {
					char = "│",
					smart_indent_cap = true,
				},
				scope = {
					enabled = false,
				},
			})
		end,
	},

	{
		"echasnovski/mini.indentscope",
		opts = {
			symbol = "┊",
			options = {
				try_as_border = true,
			},
		},
	},

	-- Navigate TMUX panes with vim window navigation keys
	{ "christoomey/vim-tmux-navigator" },

	-- TMUX integration shenaninigans
	{ "roxma/vim-tmux-clipboard" },

	-- Colorize hex codes, color names, shit like that
	{
		"norcalli/nvim-colorizer.lua",
    opts = {}
	},
	{
		"ziontee113/icon-picker.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    opts = {
      disable_legacy_commands = true
    },
    keys = {
      { '//i', '<cmd>IconPickerInsert<CR>', { mode = "i" } },
      { ',i', '<cmd>IconPickerNormal<CR>', { mode = "n" } }
    },
	}
}
