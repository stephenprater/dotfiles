return {
  {
    '3rd/image.nvim',
    config = function()
      require('image').setup()
    end
  },
  {
    'nvim-neorg/neorg',
		ft = "norg",
    cond = function()
      return not os.getenv("SPIN")
    end,
    config = function()
      require('neorg').setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {
            config = {
              icons = {
                todo = {
                  undone = {
                    icon = " "
                  }
                }
              }
            }
          },
          ["core.export"] = {
            config = {
              export_dir = "~/log/"
            }
          },
          -- ["core.completion"] = {
          --   config = {
          --     engine = "nvim-cmp", name = "[Norg]"
          --   }
          -- },
          ["core.integrations.nvim-cmp"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                log = "~/log"
              },
              index = "prater.norg"
            }
          },
        }
      })

      vim.cmd([[autocmd FileType norg setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() tw=80 sw=2]])
      vim.cmd([[autocmd FileType norg Copilot disable]])

    end
  },
  'mattn/calendar-vim',
  {
    'toppair/peek.nvim',
    build = "deno task --quiet build:fast",
    config = function ()
      require('peek').setup()

      vim.api.nvim_create_user_command('MarkdownPeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('MarkdownPeekClose', require('peek').close, {})
    end
  }
}
