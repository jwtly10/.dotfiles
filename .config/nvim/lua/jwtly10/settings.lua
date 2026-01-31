-- vim.opt.guicursor = ""
-- vim.wo.wrap = true
vim.wo.linebreak = true
vim.g.updatetime = 100
vim.opt.nu = true
vim.opt.relativenumber = true
-- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = false
-- vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "no"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "80"
-- vim.opt.colorcolumn = "120"
vim.opt.cursorline = false
vim.opt.swapfile = false
-- vim.opt.fixendofline = false
-- vim.opt.endofline = false

-- Addressing some perf issues
vim.opt.lazyredraw = true
vim.opt.ttyfast = true
vim.opt.scrolljump = 5

-- Timeout settings
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 10

-- Stop auto commenting new lines
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- Themes
-- vim.cmd("colorscheme vim")
-- vim.cmd("colorscheme onehalfdark")
