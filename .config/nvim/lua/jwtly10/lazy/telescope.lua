return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.1",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").load_extension("live_grep_args")
		require("telescope").setup({
			defaults = {
				border = true,
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<C-\\>"] = require("telescope.actions.layout").toggle_preview,
					},
				},
				preview = {
					hide_on_startup = true,
				},
			},
			pickers = {
				live_grep = {
					file_ignore_patterns = { "node_modules", ".git", ".venv" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				find_files = {
					file_ignore_patterns = { "node_modules", ".git", ".venv", "target", "dist*" },
					hidden = true,
					follow = true,
				},
				colorscheme = {
					enable_preview = true,
				},
				current_buffer_fuzzy_find = {
					enable_preview = false,
					previewer = false,
				},
			},
		})
		local builtin = require("telescope.builtin")
		local current_dir = vim.fn.getcwd()

		-- Workaround for grepping config files being potentially .gitignored
		if string.find(current_dir, "config") then
			vim.keymap.set("n", "<leader>ps", function()
				builtin.live_grep({
					cwd = vim.fn.getcwd(),
					hidden = true,
				})
			end, { desc = "Fuzzy find files dignore .gitignore" })

			vim.keymap.set("n", "<leader>pf", function()
				builtin.find_files({
					cwd = vim.fn.getcwd(),
					hidden = false,
					no_ignore = true,
				})
			end)
		else
			vim.keymap.set("n", "<leader>ps", function()
				builtin.live_grep()
			end)

			vim.keymap.set("n", "<leader>pf", function()
				builtin.find_files()
			end)
		end

		vim.keymap.set("n", "gs", function()
			builtin.grep_string({
				search = vim.fn.expand("<cword>"),
			})
		end)

		vim.keymap.set("n", "<leader>o", function()
			builtin.buffers({
				winblend = 0,
			})
		end, { desc = "Fuzzy find buffers" })

		vim.keymap.set("n", "<leader>pg", function()
			builtin.find_files(
				{ cwd = vim.fn.getcwd(), hidden = true, no_ignore = true },
				{ desc = "Fuzzy find files ignore .gitignore" }
			)
		end)

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find({
				winblend = 10,
			})
		end, { desc = "[/] Fuzzily search in current buffer]" })

		vim.keymap.set("n", "<leader>ph", function()
			builtin.help_tags({
				winblend = 0,
			}, { desc = "[?] Help tags" })
		end, { desc = "[?] Help tags" })
	end,
}
