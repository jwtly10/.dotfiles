return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme onehalfdark")
			-- vim.cmd("colorscheme onehalfdark")
			-- vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- require("nord").setup({})
			-- vim.cmd.colorscheme("nord")
			-- -- Float bg is same as bg
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3B4252" })
			-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#4C566A", bg = "#3B4252" })
		end,
	},
	-- Use this to force no background
	-- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
}
