vim.lsp.enable({
	"clang",
	"css",
	"gopls",
	"htmx",
	"java-lsp",
	"kotlin-lsp",
	"luals",
	"opencode",
	"pyright",
	"ruff",
	"ty-lsp",
	"terraform-ls",
	"texlab",
	"typescript-language-server",
	"typos-lsp",
})
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
			"<leader>ga",
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

vim.api.nvim_create_user_command("LspInfo", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if vim.tbl_isempty(clients) then
		print("No active LSP clients for this buffer.")
		return
	end

	print("=== Active LSP Client for Buffer ===")
	for _, client in ipairs(clients) do
		print(string.format("- %s (ID: %d)", client.name, client.id))
	end
end, {})
