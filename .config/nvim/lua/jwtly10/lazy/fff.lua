return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		-- will download prebuild binary or try to use existing rustup toolchain to build from source
		require("fff.download").download_or_build_binary()
	end,
	lazy = false,
	keys = {
		{
			"pf",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
		{
			"pa",
			function()
				require("fff").live_grep()
			end,
			desc = "LiFFFe grep",
		},
		{
			"ps",
			function()
				require("fff").live_grep({
					grep = {
						modes = { "fuzzy", "plain" },
					},
				})
			end,
			desc = "Live fffuzy grep",
		},
		{
			"fc",
			function()
				require("fff").live_grep({ query = vim.fn.expand("<cword>") })
			end,
			desc = "Search current word",
		},
	},

	config = function()
		require("fff").setup({
			layout = {
				preview_position = "bottom",
				prompt_position = "top",
				git = {
					status_text_color = true,
				},
			},
		})

		vim.keymap.set("n", "<leader>pg", function()
			require("fff").find_files_in_dir(vim.fn.getcwd())
		end)
	end,
}
