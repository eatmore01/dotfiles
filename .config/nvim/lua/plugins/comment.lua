return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local comment = require("Comment")
            local api = require("Comment.api")

            comment.setup({
                padding = true,
                sticky = true,
                ignore = nil,

                mappings = {
                    basic = true, -- gcc, gc, gbc, gb
                    extra = false,
                },

                -- extra = {
                -- 	above = "gco",
                -- 	below = "gco",
                -- 	eol = "gca",
                -- },

                pre_hook = nil,
                post_hook = nil,
            })
        end,
    },
}
