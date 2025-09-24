-- lua/plugins/rose-pine.lua
return {
	"rose-pine/neovim",
	name = "rose-pine",
	styles = {
		italic = false,
	},
	config = function()
		require("rose-pine").setup({
			styles = {
				italic = false,
			},
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
