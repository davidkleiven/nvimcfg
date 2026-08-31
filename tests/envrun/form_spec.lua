describe("envrun form", function()
	it("opens the form in a split so it is never the only buffer", function()
		local form = require("custom.envrun.form")
		form.open()
		local form_buf = vim.api.nvim_get_current_buf()

		-- The form is displayed in its own window, so there must be another
		-- window holding another buffer. Otherwise wiping the form on submit
		-- would close the last window and exit nvim.
		local other = vim.iter(vim.api.nvim_list_wins()):find(function(win)
			return vim.api.nvim_win_get_buf(win) ~= form_buf
		end)

		assert.is_not_nil(other)
	end)

	it("opens a form buffer and reuse it on second open", function()
		local form = require("custom.envrun.form")
		form.open()
		local first = vim.api.nvim_get_current_buf()

		form.open()
		local second = vim.api.nvim_get_current_buf()
		assert.are.same(first, second)
	end)

	it("submit parse buffer and calls on_submit with origin", function()
		local form = require("custom.envrun.form")
		local captured

		form.on_submit = function(parsed)
			captured = parsed
		end

		form.open()
		vim.api.nvim_buf_set_lines(0, 0, -1, false, { "A = 1", "COMMAND = echo 'hi'" })
		form.submit()
		assert.are.equal("echo 'hi'", captured.command)
		assert.are.equal("1", captured.env.A)
	end)

	it("binds 'q' in the form buffer to submit", function()
		local form = require("custom.envrun.form")
		local captured

		form.on_submit = function(parsed)
			captured = parsed
		end

		form.open()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "A = 1", "COMMAND = echo 'hi'" })

		local maps = vim.api.nvim_buf_get_keymap(bufnr, "n")
		local qmap = vim.iter(maps):find(function(m)
			return m.lhs == "q"
		end)
		assert.is_not_nil(qmap)

		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("q", true, false, true), "x", false)
		vim.wait(10)

		assert.are.equal("echo 'hi'", captured.command)
		assert.are.equal("1", captured.env.A)
	end)
end)
