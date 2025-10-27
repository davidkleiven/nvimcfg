local function ktlint_fix()
	local file = vim.fn.expand("%:p") -- full path to current file
	vim.cmd("write") -- save the buffer
	local result = vim.fn.system({ "ktlint", "-F", file }) -- run ktlint -F
	if vim.v.shell_error ~= 0 then
		print("ktlint error: " .. result)
	else
		vim.cmd("edit!") -- reload the file from disk
		print("ktlint -F applied and file reloaded")
	end
end

vim.api.nvim_create_user_command("KtlintFix", ktlint_fix, {
	desc = "Run ktlint -F on current file and reload it",
})

-- Optional: keymap
vim.keymap.set("n", "<leader>kf", ":KtlintFix<CR>", { desc = "Run ktlint -F" })
