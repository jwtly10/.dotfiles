return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			update_focused_file = {
				enable = true,
				update_cwd = false,
			},
		})
		vim.keymap.set("n", "<leader>pn", vim.cmd.NvimTreeToggle)
	end,
}
