-- Note that brew install fd is a requirement for some of the search opts to actually work
return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		require("fzf-lua").setup({
			keymap = {
				builtin = {
					["<C-\\>"] = "toggle-preview",
				},
			},
			previewers = {
				bat = {
					theme = "OneHalfDark",
				},
			},
			"max-perf",
			winopts = {
				backdrop = 100,
				preview = {
					layout = "vertical",
				},
			},
			files = {
				-- Exclude common build/cache directories and files but still show hidden files
				-- note: Added --follow in order to follow symlinks due to github.com/jwtly10/go-dotfiles
				fd_opts = "--follow --color=never --type f --hidden --no-ignore "
					.. "--exclude .git --exclude node_modules --exclude .venv "
					.. "--exclude venv --exclude target --exclude dist --exclude build "
					.. "--exclude .idea --exclude .settings --exclude .project "
					.. "--exclude .classpath --exclude __pycache__ --exclude .git "
					.. "--exclude .idea --exclude '*.pyc' --exclude '*.pyo' "
					.. "--exclude '*.class' --exclude '*.jar' --exclude '*.war' "
					.. "--exclude '.gradle' --exclude '.maven' --exclude '.npm' "
					.. "--exclude '.next' --exclude '.nuxt' --exclude 'coverage' "
					.. "--exclude '.coverage' --exclude '.pytest_cache' "
					.. "--exclude '.mypy_cache' --exclude '*.egg-info' "
					.. "--exclude '*DS_Store' --exclude '.ruff_cache' --exclude '.zig-cache' --exclude 'coverage.html'",
			},
			grep = {
				-- note: Added --follow in order to follow symlinks due to github.com/jwtly10/go-dotfiles
				rg_opts = "--follow --color=never --hidden --no-ignore "
					.. "--glob '!.git/' "
					.. "--glob '!node_modules/' "
					.. "--glob '!{.venv,venv}/' "
					.. "--glob '!{target,dist,build}/' "
					.. "--glob '!.idea/' "
					.. "--glob '!.settings/' "
					.. "--glob '!{.project,.classpath}' "
					.. "--glob '!**/__pycache__/' "
					.. "--glob '!*.{pyc,pyo,class,jar,war}' "
					.. "--glob '!.{gradle,maven,npm}/' "
					.. "--glob '!.{next,nuxt}/' "
					.. "--glob '!coverage/' "
					.. "--glob '!.coverage' "
					.. "--glob '!.{pytest,mypy}_cache/' "
					.. "--glob '!*.egg-info/' "
					.. "--glob '!.DS_Store' "
					.. "--glob '!site/'"
					.. "--glob '.zig-cache'"
					.. "--glob '!coverage.html'",
			},
		})

		vim.keymap.set("n", "<leader>ps", function()
			fzf.grep_project({
				-- note: Added --follow in order to follow symlinks due to github.com/jwtly10/go-dotfiles
				rg_opts = "--follow --line-number --color=never --hidden --no-ignore --ignore-case "
					.. "--glob '!.git/' "
					.. "--glob '!node_modules/' "
					.. "--glob '!{.venv,venv}/' "
					.. "--glob '!{target,dist,build}/' "
					.. "--glob '!.idea/' "
					.. "--glob '!.settings/' "
					.. "--glob '!{.project,.classpath}' "
					.. "--glob '!**/__pycache__/' "
					.. "--glob '!*.{pyc,pyo,class,jar,war}' "
					.. "--glob '!.{gradle,maven,npm}/' "
					.. "--glob '!.{next,nuxt}/' "
					.. "--glob '!coverage/' "
					.. "--glob '!.coverage' "
					.. "--glob '!.{pytest,mypy}_cache/' "
					.. "--glob '!*.egg-info/' "
					.. "--glob '!.DS_Store' "
					.. "--glob '!.zig-cache' "
					.. "--glob '!site/' "
					.. "--glob '!coverage.html'",
			})
		end)

		vim.keymap.set("n", "<leader>pf", function()
			fzf.files()
		end)

		vim.keymap.set("n", "<leader>pm", function()
			fzf.marks()
		end)

		vim.keymap.set("n", "<leader>o", function()
			fzf.oldfiles()
		end, { desc = "Fuzzy find recent files" })

		vim.keymap.set("n", "<leader>ph", function()
			fzf.helptags()
		end, { desc = "[?] Help tags" })

		-- vim.keymap.set('n', '<leader>xx', function()
		--     fzf.diagnostics_workspace()
		-- end, { desc = '[?] Diagnostics in workspace' })
	end,
}
