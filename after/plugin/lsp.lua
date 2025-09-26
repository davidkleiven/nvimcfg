vim.lsp.enable({ "luals", "gopls", "pyright", "kotlin-lsp" })

vim.diagnostic.config({
	virtual_text = { source = true },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local opts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go do definition" }))
		vim.keymap.set(
			"n",
			"gr",
			vim.lsp.buf.references,
			opts,
			vim.tbl_extend("force", opts, { desc = "Go do references" })
		)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Inspect" }))
		vim.keymap.set(
			"n",
			"<leader>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "Code actions" })
		)

		-- Optional: diagnostics float on cursor hold
		vim.api.nvim_create_autocmd("CursorHold", {
			buffer = bufnr,
			callback = function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end,
		})
	end,
})
