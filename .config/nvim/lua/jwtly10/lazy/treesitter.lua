return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"markdown",
			"markdown_inline",
			"java",
			"typescript",
			"tsx",
			"html",
			"python",
			"javascript",
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"odin",
		})
	end,
}
