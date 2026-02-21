return {
	{
		"blazkowolf/gruber-darker.nvim",
		config = function()
			require("gruber-darker").setup({
				bold = false,
				italic = {
					strings = false,
				},
			})
			vim.cmd.colorscheme("gruber-darker")
		end,
	},
}
