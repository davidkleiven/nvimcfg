local cov = require("crazy-coverage")
vim.keymap.set("n", "<leader>co", cov.toggle, { desc = "Toggle coverage" })
