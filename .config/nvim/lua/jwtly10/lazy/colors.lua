return {
	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("lackluster").setup({
				tweak_background = {
					normal = "none", -- transparent
					telescope = "default", -- telescope
					menu = "default", -- nvim_cmp, wildmenu ... (bad idea to transparent)
					popup = "default", -- lazy, mason, whichkey ... (bad idea to transparent)
				},
			})
			-- vim.cmd.colorscheme("lackluster")
		end,
	},
	{
		"deparr/tairiki.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tairiki").setup({
				palette = "dark",
				transparent = "true",
			})
			-- vim.cmd.colorscheme("tairiki")
		end,
	},
}
