local M = {}
local defaults = {}

local function wire_submit()
	require("custom.envrun.form").on_submit = function(parsed)
		require("custom.envrun.runner").run(parsed)
	end
end

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", defaults, opts or {})
	wire_submit()
end

function M.run()
	require("custom.envrun.form").open()
end

function M.submit()
	require("custom.envrun.form").submit()
end

return M
