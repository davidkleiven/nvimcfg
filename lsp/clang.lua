return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--header-insertion=iwyu",
		"--offset-encoding=utf-16",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		"compile_commands.json",
		"compile_flags.txt",
		"CMakeLists.txt",
		".git",
	},
	settings = {},
}
