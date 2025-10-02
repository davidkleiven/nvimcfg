return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		ts = require("nvim-treesitter")
		ts.install({ "go", "python", "kotlin", "markdown", "javascript" })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "go", "python", "kotlin", "markdown" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
