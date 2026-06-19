require("jwtly10")

-- Annoying deprecations
vim.deprecate = function() end

if vim.v.argv[3] and vim.fn.isdirectory(vim.v.argv[3]) == 1 then
	vim.api.nvim_set_current_dir(vim.v.argv[3])
end
