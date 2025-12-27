return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "markdown", "markdown_inline", "java", "typescript", "vue", "tsx", "html", "python", "javascript", "c", "lua", "vim", "vimdoc", "query" },
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            },
            indent = {
                enable = true,
                disable = { "py" },
            },
        }
    end
}
