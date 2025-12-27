return {
	"vim-test/vim-test",
	config = function()
		vim.g["test#strategy"] = "vimux"
		-- vim.g['test#strategy'] = 'neovim_sticky'
		-- vim.g['test#strategy'] = 'make'

		vim.g["test#python#runner"] = "pytest"
		vim.g["test#python#pytest#options"] = "-s"

		vim.g["test#rust#runner"] = "cargotest"
		vim.g["test#rust#cargotest#options"] = "-- --nocapture"

		vim.g["test#neovim#term_position"] = "botright"
		vim.g["test#neovim#term_height"] = 15

		vim.g["test#go#gotest#options"] = "-v" -- Enable verbose output for Go tests

		-- Run nearest test
		vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", { noremap = true, silent = true })

		-- Run test file
		vim.api.nvim_set_keymap("n", "<leader>tc", ":TestFile<CR>", { noremap = true, silent = true })

		-- Run last test
		vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", { noremap = true, silent = true })

		-- Run all tests
		vim.api.nvim_set_keymap("n", "<leader>ta", ":TestSuite<CR>", { noremap = true, silent = true })

		-- Visit the test file that was last run
		vim.api.nvim_set_keymap("n", "<leader>tv", ":TestVisit<CR>", { noremap = true, silent = true })
	end,
}
