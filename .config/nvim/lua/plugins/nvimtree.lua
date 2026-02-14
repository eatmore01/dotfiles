return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                auto_reload_on_write = true,
                view = {
                    width = 30,
                    preserve_window_proportions = true,
                },
                filesystem_watchers = {
                    enable = true,
                },
                sync_root_with_cwd = true,

                update_focused_file = {
                    enable = true,
                    update_root = false,
                },
                -- render = {
                --     root_folder_label = false,
                --     indent_markers = { enable = true },
                --     git_icons = {
                --         unstaged = "✗",
                --         staged = "✓",
                --     }
                -- },
            })
        end,
    },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>" },
            { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>" },
            { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>" },
            { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>" },
            { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>" },
            { "<leader>d", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close others" },
            { "<leader>q", "<Cmd>bd<CR>",                    desc = "Close buffer" },
        },
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "ordinal",      -- show nubmers
                    diagnostics = "nvim_lsp", -- error/warnings
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "center",
                        },
                    },
                    show_close_icon = true,
                },
            })
        end,
    },
}
