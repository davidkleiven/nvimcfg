require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    go = { "gofmt" },
  },
  formatters = {
    ruff_format = {
      command = "uvx",
      args = { "ruff", "format", "--stdin-filename", "$FILENAME", "-" },
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
