return {
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	"tpope/vim-fugitive",
	"nvim-tree/nvim-web-devicons",
	"github/copilot.vim",

	{
		"sindrets/diffview.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gg", function()
				local view = require("diffview.lib").get_current_view()
				if view then
					vim.cmd("DiffviewClose")
				else
					vim.cmd("DiffviewOpen")
				end
			end, { noremap = true, silent = true, desc = "Toggle Diffview" })
		end,
	},
	"preservim/vimux", -- For vim-test, and spawn test run in tmux pane

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
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
	{
		"antosha417/nvim-lsp-file-operations",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
