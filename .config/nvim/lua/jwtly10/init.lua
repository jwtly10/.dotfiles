require("jwtly10.settings")
require("jwtly10.remaps")
require("jwtly10.lazy_init")

local augroup = vim.api.nvim_create_augroup
local JGroup = augroup("jwtly10", {})

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

autocmd("LspAttach", {
	group = JGroup,
	callback = function(e)
		local opts = { buffer = e.buf }

		-- Unmap annoying lsp-like defaults
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

		-- Fzf enhanced LSP maps
		local fzf = require("fzf-lua")
		vim.keymap.set("n", "gd", function()
			fzf.lsp_definitions({ jump_to_single_result = true })
		end, opts)
		-- -- Similar to intellij - check for impls if not found, else fall back to defs
		-- vim.keymap.set("n", "gi", function()
		-- 	-- Try implementations first
		-- 	vim.lsp.buf.implementation()
		--
		-- 	-- Check after a brief delay if no results, fall back to definitions
		-- 	vim.defer_fn(function()
		-- 		local qf_list = vim.fn.getqflist()
		-- 		if #qf_list == 0 then
		-- 			fzf.lsp_definitions({ jump_to_single_result = true })
		-- 		end
		-- 	end, 100)
		-- end, opts)
		-- -- vim.keymap.set("n", "gi", function()
		-- 	local params = vim.lsp.util.make_position_params()
		-- 	vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result)
		-- 		if not err and result and not vim.tbl_isempty(result) then
		-- 			fzf.lsp_implementations({ jump_to_single_result = true })
		-- 		else
		-- 			-- Fall back to definitions
		-- 			fzf.lsp_definitions({ jump_to_single_result = true })
		-- 		end
		-- 	end)
		-- end, opts)
		vim.keymap.set("n", "gi", function()
			fzf.lsp_implementations({ jump_to_single_result = true })
		end, opts)
		vim.keymap.set("n", "gr", function()
			fzf.lsp_references()
		end, opts)
	end,
})
