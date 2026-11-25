return {
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("diffview").setup({
				view = {
					merge_tool = {
						layout = "diff3_mixed",
					},
				},
			})

			--- Key bindings ---
			vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", { silent = true })
			vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>", { silent = true })
		end,
	},
}
