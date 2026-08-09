return {
	"Jezda1337/nvim-html-css",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		enable_on = { "html", "templ" },
	},
	config = function(_, opts)
		require("html-css").setup(opts)
		vim.keymap.set("n", "<leader>cp", "<cmd>HtmlCssPeek<CR>", { desc = "Peek CSS source" })
	end,
}
