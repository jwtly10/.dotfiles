return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"gopls",
				"golangci_lint_ls",
				"ts_ls",
				"zls",
				"clangd",
				"rust_analyzer",
				"pyright",
				"ruff", -- python formatter
			},
		})

		vim.lsp.config["lua_ls"] = {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "it", "describe", "before_each", "after_each" },
					},
				},
			},
		}

		vim.lsp.config["gopls"] = {
			capabilities = capabilities,
			filetypes = { "go", "gomod" },
		}
		vim.lsp.config["golangci_lint_ls"] = {
			capabilities = capabilities,
			filetypes = { "go", "gomod" },
			init_options = {
				command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
			},
		}
		vim.lsp.config["rust_analyzer"] = {
			capabilities = capabilities,
			settings = {
				["rust-analyzer"] = {
					check = {
						command = "clippy",
					},
					PATH = "append",
				},
			},
		}
		vim.lsp.config["ts_ls"] = {
			capabilities = capabilities,
		}
		vim.lsp.config["tls"] = {
			capabilities = capabilities,
		}
		vim.lsp.config["zls"] = {
			capabilities = capabilities,
		}
		vim.lsp.config["html"] = {
			capabilities = capabilities,
		}
		vim.lsp.config["ts_ls"] = {
			capabilities = capabilities,
		}
		vim.lsp.config["clangd"] = {
			capabilities = capabilities,
			cmd = { "/opt/homebrew/opt/llvm@18/bin/clangd" },
		}

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
		})
	end,
}
