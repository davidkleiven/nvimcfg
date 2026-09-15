return {
	"Jezda1337/nvim-html-css",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		enable_on = { "html", "templ" },
		style_sheets = {
			"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
			"https://cdn.jsdelivr.net/npm/tabler@1.0.0-alpha.8/dist/css/tabler.min.css",
		},
	},
	config = function(_, opts)
		require("html-css").setup(opts)
		vim.keymap.set("n", "<leader>cp", "<cmd>HtmlCssPeek<CR>", { desc = "Peek CSS source" })
	end,
}
