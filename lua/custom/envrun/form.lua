local M = {}

local form_bufnr
local origin_file
local origin_ft

M.on_submit = nil

local function template()
	local lines = {
		"# Env - one KEY = VALUE per line",
		"ENVRUN = 1",
		"",
		"# ENVRUN_DEBUG = true to run under nvim-dap instead of a terminal",
		"ENVRUN_DEBUG = false",
		"",
		"# Command: the command to run (ignored in DEBUG mode)",
		"COMMAND =",
	}
	return lines
end

function M.submit()
	if not form_bufnr or not vim.api.nvim_buf_is_valid(form_bufnr) then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(form_bufnr, 0, -1, false)
	local parsed = require("custom.envrun.parser").parse(lines)
	parsed.origin = { file = origin_file, ft = origin_ft }
	if M.on_submit then
		M.on_submit(parsed)
	end

	M.close()
end

-- Wipe the form buffer. It lives in its own split window, so deleting it
-- never closes the last window / quits nvim.
function M.close()
	if not form_bufnr or not vim.api.nvim_buf_is_valid(form_bufnr) then
		form_bufnr = nil
		return
	end
	vim.api.nvim_buf_delete(form_bufnr, { force = true })
	form_bufnr = nil
end

function M.open()
	if form_bufnr and vim.api.nvim_buf_is_valid(form_bufnr) then
		vim.api.nvim_set_current_buf(form_bufnr)
		return
	end
	form_bufnr = vim.api.nvim_create_buf(true, false) -- listed, scratch

	origin_file = vim.fn.expand("%:p")
	origin_ft = vim.bo.filetype

	vim.api.nvim_buf_set_lines(form_bufnr, 0, -1, false, template())

	-- scratch: buffer
	vim.bo[form_bufnr].buftype = "nofile"
	vim.bo[form_bufnr].bufhidden = "wipe"
	vim.bo[form_bufnr].modifiable = true
	vim.bo[form_bufnr].filetype = "envrun"
	vim.bo[form_bufnr].swapfile = false

	-- q submits the form (shadows macro-record only inside this buffer)
	vim.api.nvim_buf_set_keymap(form_bufnr, "n", "q", "", {
		callback = function()
			M.submit()
		end,
		nowait = true,
		silent = true,
		desc = "EnvRun: run form",
	})

	-- open the form in its own split so the origin file stays visible
	vim.cmd("new")
	vim.api.nvim_win_set_buf(0, form_bufnr)
	vim.api.nvim_set_current_buf(form_bufnr)
end

return M
