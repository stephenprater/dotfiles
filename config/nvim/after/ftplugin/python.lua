local current_buffer = vim.api.nvim_get_current_buf()

vim.keymap.set("ia", "bpry", "import pdb; pdb.set_trace()", { buffer = current_buffer })
