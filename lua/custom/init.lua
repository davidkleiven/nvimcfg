require("custom.remap")
print("Hello from custom")

vim.filetype.add({
	pattern = {
		[".*/models/.*%.sql"] = "dbt_sql",
	},
})
