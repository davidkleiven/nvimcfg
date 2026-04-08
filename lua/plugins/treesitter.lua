return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		ts = require("nvim-treesitter")
		ts.install({
			"go",
			"javascript",
			"kotlin",
			"latex",
			"markdown",
			"python",
			"templ",
			"tsx",
			"turtle",
			"typescript",
			"yaml",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"go",
				"javascript",
				"kotlin",
				"markdown",
				"python",
				"templ",
				"tex",
				"tsx",
				"turtle",
				"typescript",
				"yaml",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
