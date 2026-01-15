return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre", -- load on file open
	config = function()
		local gs = require("gitsigns")
		gs.setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true, -- optional: shows inline blame
		})
	end,
}
