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
			pattern = { "go", "python", "kotlin", "markdown", "turtle", "yaml", "typescript", "tsx", "tex", "templ" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
