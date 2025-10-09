require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		go = { "gofmt" },
		json = { "jq" },
		kotlin = { "ktlint_format" },
	},
	formatters = {
		ruff_format = {
			command = "bash",
			args = {
				"-c",
				[[
			uvx ruff check --fix --stdin-filename $1 - && uvx ruff format -
			]],
				"--",
				"$FILENAME",
			},
			stdin = true,
		},
		ktlint_format = {
			command = "ktlint",
			args = { "--stdin" },
			stdin = true,
		},
	},
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
