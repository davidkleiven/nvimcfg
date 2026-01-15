local gs = require("gitsigns")

-- Navigation
vim.keymap.set("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	gs.next_hunk()
end, { desc = "Next Git hunk" })

vim.keymap.set("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	gs.prev_hunk()
end, { desc = "Previous Git hunk" })

-- Actions
vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("v", "<leader>hs", function()
	gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage visual hunk" })
vim.keymap.set("v", "<leader>hr", function()
	gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Reset visual hunk" })

-- Blame
vim.keymap.set("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })

-- Preview
vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

-- Undo stage
vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })

-- Diff the hunk
vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff this hunk" })

-- Toggle current line blame
vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
