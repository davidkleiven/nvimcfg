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
	root_dir = function(fname)
		if vim.fs.root(fname, ".ty") then
			return nil
		end
		return vim.fs.root(fname, "pyproject.toml")
	end,
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
