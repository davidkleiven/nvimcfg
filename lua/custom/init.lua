require("custom.remap")
print("Hello from custom")
vim.filetype.add({
	extension = {
		tf = "terraform",
		tfvars = "terraform",
	},
})
