vim.wo.linebreak = true
vim.g.updatetime = 100
vim.opt.nu = true
vim.opt.relativenumber = false
vim.opt.number = true
-- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.cursorline = false
vim.opt.swapfile = false
vim.opt.cmdheight = 0

-- Addressing some perf issues
vim.opt.lazyredraw = true
vim.opt.ttyfast = true
vim.opt.scrolljump = 5

-- Timeout settings
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 10

-- Stop auto commenting new lines
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Uncomment if using nerd-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- vim.cmd("colorscheme black")
vim.cmd("colorscheme onehalfdark")
