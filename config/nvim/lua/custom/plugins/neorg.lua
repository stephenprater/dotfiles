return {
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      tmux_show_only_in_active_window = true,
      editor_only_render_when_focused = true,
      integrations = {
        markdown = {
          enabled = false
        }
      }
    },
    keys = {
      { "<LocalLeader>ci", function()
          vim.fn.system("zsh -c 'clear_images'")
        end, desc = "Clear Kitty Images"
      }
    }
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    ft = "norg",
    cond = function()
      return not os.getenv("SPIN")
    end,
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
          config = {
            icons = {
              todo = {
                undone = {
                  icon = " ",
                },
              },
            },
          },
        },
        ["core.export"] = {
          config = {
            export_dir = "~/log/",
          },
        },
        ["core.tangle"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              log = "~/log",
            },
            index = "prater.norg",
          },
        },
        ["core.completion"] = {
          config = {
            engine = {
              module_name = "external.lsp-completion"
            }
          }
        },
        ["external.interim-ls"] = {
          config = {
            completion_provider = {
              enable = true,
              documentation = true
            }
          }
        },
      }
    },
    keys = {
      { "<LocalLeader>td", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", mode = "n", ft = "norg", desc = "Cycle Todo" },
      { "<LocalLeader>tx", "<Plug>(neorg.qol.todo-items.todo.task-done)", mode = "n", ft = "norg", desc = "Todo Done" },
    }
  },
  {
    "benlubas/neorg-interim-ls",
    dependencies = { "nvim-neorg/neorg" }
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()

      vim.api.nvim_create_user_command("MarkdownPeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("MarkdownPeekClose", require("peek").close, {})
    end,
  },
}
