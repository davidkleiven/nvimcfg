local M = {}

local function get_error_source()
	local line = vim.api.nvim_get_current_line()
	local rhs = line:match("err%s*:?=%s*(.+)")
	if not rhs then
		return "operation"
	end
	local name = rhs:match("([%w_]+)%s*%(")
	return name and (name:sub(1, 1):lower() .. name:sub(2)) or "operation"
end

function M.wrap()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)

	local row = cursor[1]
	local col = cursor[2]

	local source = get_error_source()
	local message = string.format('fmt.Errorf("%s: %%w", err)', source)
	local pos = vim.api.nvim_buf_get_offset(bufnr, row - 1) + col
	local cmd = {
		"iferr",
		"-pos",
		tostring(pos),
		"-message",
		message,
	}
	local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
	local output = vim.fn.system(cmd, input)

	if vim.v.shell_error ~= 0 then
		vim.notify(output, vim.log.levels.ERROR)
	end

	local generated = vim.split(vim.trim(output), "\n", { plain = true })
	vim.api.nvim_buf_set_lines(bufnr, row, row, false, generated)
end

return M
