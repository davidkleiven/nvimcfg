local function get_venv_python()
	local cwd = vim.fn.getcwd()
	local path = cwd .. "/.venv/bin/python"
	if vim.fn.executable(path) == 1 then
		return path
	end
	return "python"
end

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
			pythonPath = get_venv_python(),
		},
	},
}
