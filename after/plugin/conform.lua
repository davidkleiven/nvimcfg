local function go_formatters(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	local root = vim.fs.root(name, { ".gofumpt", ".golangci.yml", ".golangci.yaml", "go.mod" })
	local has_goimports = vim.fn.executable("goimports") == 1
	local has_gofumpt = vim.fn.executable("gofumpt") == 1
	local has_gofmt = vim.fn.executable("gofmt") == 1

	if root and vim.fn.filereadable(root .. "/.gofumpt") == 1 and has_goimports and has_gofumpt then
		return { "goimports", "gofumpt" }
	end
	if has_goimports then
		return { "goimports" }
	end
	if has_gofmt then
		return { "gofmt" }
	end
	return {}
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		go = go_formatters,
		json = { "jq2sp" },
		html = { "prettier" },
		sql = { "sqlfmt" },
		templ = { "templ" },
		terraform = { "terrafmt" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
	},
	formatters = {
		jq2sp = {
			inherit = false,
			command = "jq",
			args = { "--indent", "2", "." },
			stdin = true,
		},
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
		terrafmt = {
			command = "terraform",
			args = { "fmt" },
		},
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	once = true,
	callback = function()
		vim.schedule(function()
			local has_goimports = vim.fn.executable("goimports") == 1
			local has_gofumpt = vim.fn.executable("gofumpt") == 1
			local has_gofmt = vim.fn.executable("gofmt") == 1
			local buf = vim.api.nvim_get_current_buf()
			local name = vim.api.nvim_buf_get_name(buf)
			local root = vim.fs.root(name, { ".gofumpt", ".golangci.yml", ".golangci.yaml", "go.mod" })
			if root and vim.fn.filereadable(root .. "./gofumpt") == 1 and has_goimports and has_gofumpt then
				vim.notify("Go formatters: goimports + gofumpt")
			elseif has_goimports then
				vim.notify("Go formatters: goimports")
			elseif has_gofmt then
				vim.notify("Go formatters: gofmt")
			else
				vim.notify("Go formatters: none available", vim.log.levels.WARN)
			end
		end)
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		local bufnr = args.buf
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local text = table.concat(lines, "\n")
		-- skip formatting for jinja files
		if text:find("{{") or text:find("{%%") then
			return
		end
		require("conform").format({ bufnr = args.buf, async=false })
	end,
})
