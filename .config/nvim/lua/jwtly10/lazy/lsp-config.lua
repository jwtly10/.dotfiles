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
	},
	config = function()
		local cmp = require("cmp")

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		require("mason").setup()

		-- vim.lsp.inlay_hint.enable(true)

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "it", "describe", "before_each", "after_each" },
						},
					},
				},
			},

			gopls = {
				filetypes = { "go", "gomod" },
			},

			golangci_lint_ls = {
				filetypes = { "go", "gomod" },
				init_options = {
					command = {
						"golangci-lint",
						"run",
						"--output.json.path=stdout",
						"--show-stats=false",
					},
				},
			},

			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
						PATH = "append",
					},
				},
			},

			ols = {},
			ts_ls = {},
			-- ZLS
			-- zls = {},
			-- Custom LSP https://github.com/llogick/zigscient
			zls = {
				cmd = { "/Users/personal/Projects/zig-libs/zigscient/zig-out/bin/zigscient" },
				filetypes = { "zig", "zir" },
				root_dir = vim.fs.root(0, { "build.zig", ".git" }),
			},
			html = {},

			clangd = {
				cmd = { "/opt/homebrew/opt/llvm@18/bin/clangd" },
			},

			basedpyright = {},
			ruff = {},
		}

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		for server, config in pairs(servers) do
			config.capabilities = capabilities
			vim.lsp.config(server, config)
		end

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = "*.pine",
			callback = function()
				vim.lsp.start({
					name = "donsumi-lsp",
					cmd = { "/Users/personal/Projects/codext/target/debug/donsumi-lsp" },
					root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
				})
			end,
		})

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
