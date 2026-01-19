return {
	{
		"shaunsingh/nord.nvim",
		config = function()
			vim.g.nord_italic = false
			-- vim.cmd("colorscheme nord")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				no_italic = true,
			})

			vim.cmd("colorscheme catppuccin-frappe")
		end,
	},
}
