return {
	{
	"nvim-neotest/neotest",
	lazy = true,
	event = "BufAdd */*test*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"zidhuss/neotest-minitest",
		"marilari88/neotest-vitest",
    "nvim-neotest/neotest-python",
	},
	config = function ()
		require("neotest").setup {
			adapters = {
				require("neotest-minitest")({
					test_cmd = function()
						return vim.tbl_flatten(
							{
								"bundle",
								"exec",
								"ruby",
								"-Ilib:test",
							}
						)
					end
				}),
				require("neotest-vitest"),
        require("neotest-python"),
			},
		}
	end
}
}
