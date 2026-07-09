return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		ts = require("nvim-treesitter")
		ts.install({
			"go",
			"hcl",
			"hurl",
			"javascript",
			"kotlin",
			"latex",
			"lua",
			"markdown",
			"python",
			"templ",
			"terraform",
			"tsx",
			"turtle",
			"typescript",
			"yaml",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"go",
				"hurl",
				"javascript",
				"kotlin",
				"lua",
				"markdown",
				"python",
				"templ",
				"terraform",
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
