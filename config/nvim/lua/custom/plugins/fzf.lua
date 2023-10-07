return {
  { 'junegunn/fzf', build = ':call fzf#install(})' },
	{ 'junegunn/fzf.vim' },
	{ 'gfanto/fzf-lsp.nvim' },
	{
		'ibhagwan/fzf-lua',
		dependencies = { "nvim-tree/nvim-web-devicons" },
 	},
}

