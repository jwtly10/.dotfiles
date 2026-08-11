return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters = {
				odinfmt = {
					-- Change where to find the command if it isn't in your path.
					command = "odinfmt",
					args = { "-stdin" },
					stdin = true,
				},
				prettier = {
					prepend_args = function()
						return {
							"--no-semi",
							"--single-quote",
							"--no-bracket-spacing",
							"--print-width",
							"80",
							"--config-precedence",
							"prefer-file",
							"--with-node-modules",
						}
					end,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt", lsp_format = "fallback" },
				go = { "gofmt", "goimports", lsp_format = "fallback" },
				javascript = { "prettier" },
				python = { lsp_format = "fallback" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				less = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				zig = { "zigfmt" },
				odin = { "odinfmt" },
				["markdown.mdx"] = { "prettier" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})

		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		-- Default to disabled
		vim.g.disable_autoformat = true

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		vim.api.nvim_create_user_command("Format", function()
			require("conform").format({
				async = true,
				lsp_format = "fallback",
			})
		end, {
			desc = "Format current file",
		})
	end,
}
