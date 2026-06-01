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

vim.api.nvim_create_user_command("RosePine", function(opts)
	local variant = opts.args
	if variant == "" then
		print("Usage: RosePine main | moon | dawn")
		return
	end

	vim.g.rose_pine_variant = variant
	vim.opt.background = (variant == "dawn") and "light" or "dark"
	vim.cmd("colorscheme rose-pine")
end, {
	nargs = 1,
	complete = function()
		return { "main", "moon", "dark" }
	end,
})
