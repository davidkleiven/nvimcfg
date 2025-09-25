return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/neotest-python",
		"fredrikaverpil/neotest-golang",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-golang"),
			},
		})
		-- Keybindings (set once during setup)
		vim.keymap.set("n", "<leader>tr", function()
			neotest.run.run()
		end, { desc = "Run nearest test" })

		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Debug nearest test" })

		vim.keymap.set("n", "<leader>tl", function()
			neotest.run.run_last()
		end, { desc = "Run last test" })
	end,
}
