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
    config = function()
      require("barbecue").setup({
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
      })
    end,
  },

  -- Status line written in Lua
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/lsp-status.nvim",
      "folke/noice.nvim",
    },
    config = function()
      local custom_nord = require("lualine.themes.nord")
      custom_nord.normal.c.bg = "#1f1f28"
      custom_nord.normal.b.bg = "#1f1f28"
      custom_nord.normal.a.bg = "#1f1f28"

      local lsp_status = require("lsp-status")

      local noice = function()
        if(require('noice').api.status.mode.has) then
          local status = require('noice').api.status.mode.get()
          local start, stop = status:find("recording ..")
          if(start ~= nil) then
            local add = status:sub(start, stop)
            return "%#NoiceAttr253#" .. add
          end
        end

        return ""
      end


      require("lualine").setup({
        options = { theme = custom_nord },
        sections = {
          lualine_a = {
            "mode",
            noice
          },
          lualine_y = {
            "progress",
            lsp_status.status,
          },
        }
      })
    end,
  },

  -- Put the status of the LSP
  {
    "nvim-lua/lsp-status.nvim",
    config = function()
      local lsp_status = require("lsp-status")
      lsp_status.register_progress()
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
        window = {
          border = "single"
        }
      })

      wk.register({
        ["]"] = {
          name = "window",
          ["-"] = { "<C-W>-", "Size Down" },
          ["="] = { "<C-W>+", "Size Up" },
          ["."] = { "<C-W>>", "Size Right" },
          [","] = { "<C-W><", "Size Left" },
          ["j"] = { "<C-W>", "Move Down" },
          ["k"] = { "<C-W>k", "Move Up" },
          ["h"] = { "<C-W>h", "Move Left" },
          ["l"] = { "<C-W>l", "Move Right" },
          ["_"] = { ":split<cr>", "Horizontal Split" },
          ["|"] = { ":vsplit<cr>", "Vertical Split" },
          ["o"] = { ":bn<cr>", "Next Buffer" },
          ["p"] = { ":bp<cr>", "Previous Buffer" },
          ["}"] = { ":tabnext<cr>", "Next Tab" },
          ["{"] = { ":tabprev<cr>", "Previous Tab" },
        },
        [","] = {
          name = "navigate",
          ["cn"] = { ":cn<CR>", "Next Quickfix" },
          ["cp"] = { ":cp<CR>", "Next Quickfix" },
          ["tn"] = { ":tn<CR>", "Next Quickfix" },
          ["tp"] = { ":tp<CR>", "Next Quickfix" },
          ["tb"] = { ":TagbarToggle<CR>", "Show Tagbar" },
          ["gu"] = { ":UndotreeShow<CR>", "Show Undotree" },
          ["bs"] = { ":Buffers<CR>", "Show Buffers" },
          ["mr"] = { ":History<CR>", "Show History" },
          ["q:"] = { ":History:<CR>", "Show Command History" },
          ["mk"] = { ":MarkologyToggle<CR>", "Show Marks" },
          ["rn"] = { ":lua require('functions').toggle_relative_numbers", "Toggle Relative Numbers" },
          ["no"] = { ":Neotest output-panel<CR>", "Neotest Output" },
          ["ns"] = { ":Neotest summary<CR>", "Neotest Summary" },
          ["nt"] = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },
          ["yr"] = { ":YanksBefore<CR>", "Yank Ring" },
          ["mp"] = { function()
            local preview_open = require("peek").is_open()
            if(preview_open) then
              require("peek").close()
            else
              require("peek").open()
            end
          end, "Markdown Preview" },
        },
        ["<leader>"] = {
          name = "tests",
          ["nt"] = { function() require("neotest").run.run() end, "Test Nearest" },
          ["nT"] = { function() require("neotest").run.run(vim.fn.expand("%")) end, "Test File" },
          ["ntd"] = { function() require("neotest").run.run({strategy = "dap"}) end, "Debug Test" },
          ["t"] = { ":TestNearest<CR>", "Test Nearest" },
          ["T"] = { ":TestFile<CR>", "Test File" },
          ["g"] = {
            name = "Git",
            ["a"] = { function() require("gitsigns").stage_hunk() end, "Stage Hunk" },
            ["r"] = { function() require("gitsigns").reset_hunk() end, "Reset Hunk" },
            ["b"] = { function() require("gitsigns").blame_line() end, "Blame Line" },
            ["d"] = { function() require("gitsigns").toggle_deleted() end, "Toggle Deleted" },
            ["p"] = { function() require("gitsigns").preview_hunk() end, "Preview Hunk" },
            ["s"] = { function() require("gitsigns").select_hunk() end, "Select Hunk" },
            ["u"] = { function() require("gitsigns").undo_stage_hunk() end, "Undo Stage Hunk" },
            ["U"] = { function() require("gitsigns").reset_buffer() end, "Reset Buffer" },
            ["l"] = { function() require("gitsigns").toggle_current_line_blame() end, "Toggle Line Blame" },
          },
          ["l"] = {
            name = "LSP",
            ["h"] = { ":lua vim.lsp.buf.hover()<CR>", "Hover" },
            ["d"] = { ":lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
            ["r"] = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
            ["?"] = { ":lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
            ["]"] = { ":References<CR>", "Show References" },
            ["a"] = { ":CodeActions<CR>", "Code Actions" },
            ["x"] = { ":lua vim.diagnostic.open_float({focusable=false})<CR>", "Open Diagnostic Float" },
            ["s"] = { ":lua vim.lsp.buf.document_symbol()<CR>", "Open Document Symbols" },
          },
        },
        ["g<"] = { ":ISwapNodeWithLeft<CR>", "Swap Left" },
        ["g>"] = { ":ISwapNodeWithRight<CR>", "Swap Right" },
        ["gs"] =  { ":ISwap<CR>", "Interactive Swap" },
        ["<leader>d"] = {
          name = "Debugger",
          ["b"] = { ":lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
          ["n"] = { ":lua require('dap').step_over()<CR>", "Step Over" },
          ["i"] = { ":lua require('dap').step_into()<CR>", "Step Into" },
          ["c"] = { ":lua require('dap').continue()<CR>", "Continue" },
          ["f"] = { ":lua require('dap').step_out()<CR>", "Step Out" },
          ["<F5>"] = { ":lua require('osv').launch({port=8086})<CR>", "Connect to Lua" },
          ["u"] = { function() require("dapui").toggle({}) end, "Toggle DAP UI" }
        },
        ["<leader><leader>"] = {
          name = "Tools",
          ["bc"] = { ":silent . !bc<CR>", "Calculate" },
          ["da"] = { ":.!date<CR>", "Today's Date" },
          ["l"] = { ":Neorg workspace log<CR>", "Log" },
        },
      })
    end,
  },


  { 'MunifTanjim/nui.nvim' },

  {
    'folke/noice.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      cmdline_popupmenu = {
        view = "cmp"
      },
      presets = {
        command_palette = false,
        lsp_doc_border = true,
      },
      cmdline = {
        view = "cmdline"
      }
    }
  },

  -- Multiple cursors
  "mg979/vim-visual-multi",

  -- Increment a each element in a visual selection
  "triglav/vim-visual-increment",

  -- Pretty UI
  {
    "stevearc/dressing.nvim",
    config = function()
      local dressing = require("dressing")
      dressing.setup({
        select = {
          backend = { "fzf", "fzf_lua", "telescope", "builtin", "nui" },
        },
      })
    end,
  },

  -- Popup Notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#161616",
      })
      vim.notify = notify
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- Adds indentation guides to blank lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#34342d" })
      vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#34342d" })
      require("ibl").setup({
        indent = {
          char = "│",
          smart_indent_cap = true,
        },
        scope = {
          enabled = false
        }
      })
    end,
  },

  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = '┊',
      options = {
        try_as_border = true
      }
    }
  },

  -- Navigate TMUX panes with vim window navigation keys
  { "christoomey/vim-tmux-navigator" },

  -- TMUX integration shenaninigans
  { "roxma/vim-tmux-clipboard" },

  -- Colorize hex codes, color names, shit like that
  {
    'norcalli/nvim-colorizer.lua',
    config = function ()
      require('colorizer').setup()
    end
  },

  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })

      vim.keymap.set("n", "<C-K>", ":IconPickerNormal<CR>", { noremap = true, silent = true })
      vim.keymap.set("i", "<C-K>", ":IconPickerInsert<CR>", { noremap = true, silent = true })
    end,
  },
}
