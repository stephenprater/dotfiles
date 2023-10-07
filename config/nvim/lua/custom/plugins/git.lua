return {
	{
		'lewis6991/gitsigns.nvim', config = function()
			require('gitsigns').setup()
		end
	},
	{ 'whiteinge/diffconflicts' },
	{ 'tpope/vim-fugitive' },
	{ 'tpope/vim-git' },
}
