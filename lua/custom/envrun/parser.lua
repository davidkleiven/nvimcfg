local M = {}

-- Returns { env = {KEY = VALUE, ...}, command = string|nil, debug = boolean }
--
-- KEY = VALUE lines become env vars, except the reserved specials:
--   COMMAND = ...       -> the command to run (nil when empty)
--   ENVRUN_DEBUG = true -> run under nvim-dap instead of a terminal
-- Blank lines and lines starting with '#' are ignored.
function M.parse(lines)
	local env = {}
	local command = nil
	local debug = false

	for _, line in ipairs(lines) do
		local trimmed = vim.trim(line)
		if trimmed ~= "" and not vim.startswith(trimmed, "#") then
			local key, value = trimmed:match("^([^=]+)%s*=%s*(.*)$")
			if key then
				key = vim.trim(key)
				local lower = key:lower()
				if lower == "command" then
					local v = vim.trim(value)
					command = v ~= "" and v or nil
				elseif key == "ENVRUN_DEBUG" then
					local v = vim.trim(value):lower()
					debug = v == "true" or v == "1"
				else
					env[key] = vim.trim(value)
				end
			end
		end
	end

	return { env = env, command = command, debug = debug }
end

return M
