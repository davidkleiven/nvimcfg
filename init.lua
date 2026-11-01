require("custom")
require("config.lazy")
require("custom.ktlint")

vim.o.signcolumn = "yes"
vim.opt.number = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.keymap.set("n", "<leader>ge", function()
			require("custom.iferr").wrap()
		end, {
			buffer = true,
			desc = "Generated wrapped Go error",
		})
	end,
})
