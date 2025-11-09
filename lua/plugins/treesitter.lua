return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		ts = require("nvim-treesitter")
		ts.install({ "go", "python", "kotlin", "markdown", "javascript", "turtle", "yaml" })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "go", "python", "kotlin", "markdown", "turtle", "yaml" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
