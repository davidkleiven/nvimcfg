require("custom.remap")
vim.filetype.add({
	extension = {
		tf = "terraform",
		tfvars = "terraform",
	},
})

vim.api.nvim_create_user_command("LspRestart", function()
	local clients = vim.lsp.get_clients()
	for _, client in ipairs(clients) do
		client:stop()
	end

	vim.defer_fn(function()
		vim.cmd("edit")
	end, 100)
end, {})
