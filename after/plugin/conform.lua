require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		go = { "gofmt" },
		json = { "jq" },
		html = { "prettier" },
		sql = { "sqlfmt" },
	},
	formatters = {
		ruff_format = {
			command = "bash",
			args = {
				"-c",
				[[
			uvx ruff check --fix --stdin-filename $1 -
			]],
				"--",
				"$FILENAME",
			},
			stdin = true,
		},
		sqlfmt = {
			command = "sqruff",
			args = { "fix", "$FILENAME" },
			stdin = false,
		},
	},
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
