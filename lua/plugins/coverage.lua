return {
	"mr-u0b0dy/crazy-coverage.nvim",
	config = function()
		require("crazy-coverage").setup({
			show_coverage_in_sign_column = true,
		})
	end,
}
