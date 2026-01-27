return {
	cmd = { "texlab" },
	filetypes = {"tex", "plaintex", "bib" },
	root_markers = {
		".latexmkrc",
    "latexmkrc",
    "texlabroot",
    "Tectonic.toml",
    ".git",
	},
	settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
          "%f",
        },
        onSave = true,
      },

      forwardSearch = {
        executable = "zathura", -- okular / skim / sumatrapdf
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },

      chktex = {
        onOpenAndSave = true,
        onEdit = false,
      },

      diagnosticsDelay = 300,
      formatterLineLength = 80,
    },
  },
}
