require("jwtly10")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Comment above, uncomment below to use Netrw
-- vim.keymap.set("n", "<leader>pn", ":Ex<CR>", { noremap = true, silent = true })

-- Annoying deprecations - I won't update
vim.deprecate = function() end

if vim.v.argv[3] and vim.fn.isdirectory(vim.v.argv[3]) == 1 then
	vim.api.nvim_set_current_dir(vim.v.argv[3])
end

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.mq4",
-- 	callback = function()
-- 		local cursor_pos = vim.api.nvim_win_get_cursor(0)
--
-- 		vim.cmd([[normal! gg=G]])
--
-- 		vim.api.nvim_win_set_cursor(0, cursor_pos)
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.mq5",
-- 	callback = function()
-- 		local cursor_pos = vim.api.nvim_win_get_cursor(0)
--
-- 		vim.cmd([[normal! gg=G]])
--
-- 		vim.api.nvim_win_set_cursor(0, cursor_pos)
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.mqh",
-- 	callback = function()
-- 		local cursor_pos = vim.api.nvim_win_get_cursor(0)
--
-- 		vim.cmd([[normal! gg=G]])
--
-- 		vim.api.nvim_win_set_cursor(0, cursor_pos)
-- 	end,
-- })
