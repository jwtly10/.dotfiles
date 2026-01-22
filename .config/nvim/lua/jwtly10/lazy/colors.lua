return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				no_italic = false, -- Force no italic
			})
			-- vim.cmd.colorscheme("catppuccin-frappe")
		end,
	},
}
-- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
