return {
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("diffview").setup()

			--- Key bindings ---
			vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", { silent = true })
			vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { silent = true })
			vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>", { silent = true })
		end,
	},
}
