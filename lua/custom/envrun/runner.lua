local M = {}

-- Production I/O boundaries. A fresh table (not module fields) so tests can
-- supply their own per call without mutating this module or tripping LuaLS's
-- duplicate-index diagnostic.
local function prod_bounds()
	return {
		spawn = vim.fn.jobstart,
		dap = nil, -- lazily required on first debug run
		open_terminal_tab = function()
			vim.cmd("tabnew")
		end,
	}
end

local function get_dap(opts)
	local dap = opts.dap or require("dap")
	opts.dap = dap -- cache after first require
	return dap
end

local function run_command(command, env, opts)
	opts.open_terminal_tab() -- open the terminal in its own new tab
	-- nvim rejects an empty plain-table opts dict, so only pass env when set.
	local id = next(env) and opts.spawn(command, { term = true, env = env }) or opts.spawn(command, { term = true })
	if id == 0 then
		vim.notify("EnvRun: failed to launch command", vim.log.levels.ERROR)
	end
end

local function default_command(parsed)
	local ft = parsed.origin.ft
	if ft == "go" then
		return "go run " .. parsed.origin.file
	elseif ft == "python" then
		return "uv run python " .. parsed.origin.file
	end
	return nil
end

-- Launch a nvim-dap session with the env vars set.
local function debug_run(parsed, opts)
	local dap = get_dap(opts)
	local ft = parsed.origin.ft
	local program = parsed.origin.file
	local env = parsed.env

	if ft == "go" then
		dap.run({
			type = "go",
			request = "launch",
			name = "EnvRun",
			program = program,
			env = env,
		})
	elseif ft == "python" then
		dap.run({
			type = "python",
			request = "launch",
			name = "EnvRun",
			program = program,
			env = env,
		})
	else
		vim.notify("EnvRun: unsupported filetype for DEBUG: " .. ft, vim.log.levels.WARN)
	end
end

function M.run(parsed, opts)
	opts = vim.tbl_deep_extend("force", prod_bounds(), opts or {})

	if parsed.debug then
		debug_run(parsed, opts)
		return
	end

	local command = parsed.command or default_command(parsed)
	if not command then
		vim.notify("EnvRun: no command given and no default for filetype " .. parsed.origin.ft, vim.log.levels.WARN)
		return
	end

	run_command(command, parsed.env, opts)
end

return M
