require("jwtly10.settings")
require("jwtly10.remaps")
require("jwtly10.lazy_init")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

local JGroup = augroup("jwtly10", {})
autocmd("LspAttach", {
	group = JGroup,
	callback = function(e)
		local opts = { buffer = e.buf }

		-- Nvim LSP Defaults
		pcall(function()
			vim.keymap.del("n", "grr")
			vim.keymap.del("n", "gri")
			vim.keymap.del("n", "gra")
			vim.keymap.del("n", "grn")
		end)

		-- Native LSP maps
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "gt", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "gu", function()
			vim.lsp.buf.usages()
		end, opts)
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)

		-- Telescope
		vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)
		vim.keymap.set("n", "gt", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
		vim.keymap.set("n", "gu", function()
			vim.lsp.buf.usages()
		end, opts)
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})
