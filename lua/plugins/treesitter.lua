return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		ts = require("nvim-treesitter")
		ts.install({ "go", "python", "kotlin", "markdown", "javascript", "turtle", "yaml", "typescript", "tsx" })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "go", "python", "kotlin", "markdown", "turtle", "yaml", "typescript", "tsx" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
