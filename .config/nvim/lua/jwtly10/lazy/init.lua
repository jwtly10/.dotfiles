return {
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	"tpope/vim-fugitive",
	"nvim-tree/nvim-web-devicons",
	"github/copilot.vim",
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
}
