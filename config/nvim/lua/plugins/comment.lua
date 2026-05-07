return {
	{
		"echasnovski/mini.comment",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			mappings = {
				comment = nil,
				comment_line = nil,
				comment_visual = nil,
				comment_repeat = nil,
			},

			options = {
				custom_commentstring = nil,
				ignore_blank_line = true,
			},
		},
	},
}
