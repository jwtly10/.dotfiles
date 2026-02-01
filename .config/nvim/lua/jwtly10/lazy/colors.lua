return {
	{
		"sainnhe/sonokai",
		config = function()
			vim.g.sonokai_enable_italic = false
			-- vim.cmd.colorscheme("sonokai")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				no_italic = false,
				-- transparent_background = true,
				-- float = {
				-- 	transparent = true,
				-- 	solid = false,
				-- },
			})
			-- vim.cmd.colorscheme("catppuccin-frappe")
			-- vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.nord_italic = false
			vim.g.nord_bold = false
			-- vim.cmd.colorscheme("nord")
			-- Make float window more noticable
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3B4252" })
			-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#4C566A", bg = "#3B4252" })
		end,
	},
}
-- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
