return {
	cmd = { "uvx", "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml" },

	settings = {
		-- Ruff-specific LSP settings
		ruff_lsp = {
			config = {
				-- Enable hover? (many disable this to avoid conflicts)
				hover = false,
			},
		},
	},
}
