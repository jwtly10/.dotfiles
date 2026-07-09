return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local ignore_build_dirs =
			{ "target", ".zig-cache", "zig-out", "node_modules", ".git", ".venv", "dist", ".idea" }

		local function fd_excludes()
			local args = {}
			for _, pattern in ipairs(ignore_build_dirs) do
				vim.list_extend(args, { "--exclude", pattern })
			end
			return args
		end

		local function rg_excludes()
			local args = {}
			for _, pattern in ipairs(ignore_build_dirs) do
				vim.list_extend(args, { "--glob", "!**/" .. pattern .. "/**" })
			end
			return args
		end

		require("telescope").load_extension("live_grep_args")
		require("telescope").setup({
			defaults = {
				border = true,
				layout_strategy = "vertical",
				layout_config = {
					width = 0.95,
					height = 0.85,
					preview_cutoff = 25,
					prompt_position = "top",
					horizontal = {
						preview_width = function(_, cols, _)
							if cols > 200 then
								return math.floor(cols * 0.4)
							else
								return math.floor(cols * 0.6)
							end
						end,
					},
					vertical = { width = 0.9, height = 0.95, preview_height = 0.5, mirror = true },
					flex = { horizontal = { preview_width = 0.9 } },
				},
				sorting_strategy = "ascending",
				cache_picker = {
					num_pickers = 10,
				},
				mappings = {
					i = {
						["<C-\\>"] = require("telescope.actions.layout").toggle_preview,
					},
				},
				preview = {
					hide_on_startup = false,
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					follow = true,
					find_command = vim.list_extend({
						"fd",
						"--type",
						"f",
						"--hidden",
						"--follow",
					}, fd_excludes()),
				},
				live_grep = {
					additional_args = function()
						return vim.list_extend({ "--hidden" }, rg_excludes())
					end,
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

		vim.keymap.set("n", "<leader>ps", function()
			builtin.live_grep()
		end)

		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files()
		end)

		-- 9/7/26 - No longer needed since i use dotfiles
		-- local current_dir = vim.fn.getcwd()
		-- Workaround for grepping config files being potentially .gitignored
		-- if string.find(current_dir, "config") then
		-- 	vim.keymap.set("n", "<leader>ps", function()
		-- 		builtin.live_grep({
		-- 			cwd = vim.fn.getcwd(),
		-- 			hidden = true,
		-- 		})
		-- 	end, { desc = "Fuzzy find files dignore .gitignore" })
		--
		-- 	vim.keymap.set("n", "<leader>pf", function()
		-- 		builtin.find_files({
		-- 			cwd = vim.fn.getcwd(),
		-- 			hidden = false,
		-- 			no_ignore = true,
		-- 		})
		-- 	end)
		-- else
		-- 	vim.keymap.set("n", "<leader>ps", function()
		-- 		builtin.live_grep()
		-- 	end)
		-- 	vim.keymap.set("n", "<leader>ps", function()
		-- 		builtin.live_grep()
		-- 	end)
		--
		-- 	vim.keymap.set("n", "<leader>pf", function()
		-- 		builtin.find_files()
		-- 	end)
		-- end

		vim.keymap.set("n", "gs", function()
			builtin.grep_string({
				search = vim.fn.expand("<cword>"),
			})
		end)

		vim.keymap.set("n", "<leader>pl", function()
			require("telescope.builtin").resume()
		end, { desc = "Resume last telescope picker" })

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
		vim.keymap.set("n", "<leader>xx", function()
			builtin.diagnostics({
				winblend = 0,
			})
		end, { desc = "[?] Diagnostics" })
	end,
}
