local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

return {
	cmd = {
		"jdtls",
		"-data",
		workspace_dir,
		-- These JVM args help performance and compatibility
		"--jvm-arg=-Xmx1G",
		"--jvm-arg=-XX:+UseG1GC",
		"--jvm-arg=-XX:+ParallelRefProcEnabled",
	},
	root_markers = {
		".git",
		"mvnw",
		"gradlew",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
	},
	filetypes = { "java" },
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
		},
	},
}
