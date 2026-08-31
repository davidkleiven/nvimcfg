local runner = require("custom.envrun.runner")

describe("envrun runner", function()
	it("launches the command via jobstart with the env table", function()
		local calls
		runner.run(
			{
				command = "echo hi",
				env = { A = "1" },
				debug = false,
				origin = { file = "/tmp/main.go", ft = "go" },
			},
			{
				spawn = function(cmd, opts)
					calls = { cmd = cmd, opts = opts }
					return 1
				end,
				open_terminal_tab = function() end,
			}
		)

		assert.are.equal("echo hi", calls.cmd)
		assert.are.equal("1", calls.opts.env.A)
		assert.is_true(calls.opts.term)
	end)

	it("falls back to the filetype default command for go", function()
		local calls
		runner.run(
			{
				command = nil,
				env = {},
				debug = false,
				origin = { file = "/tmp/main.go", ft = "go" },
			},
			{
				spawn = function(cmd, opts)
					calls = { cmd = cmd, opts = opts }
					return 1
				end,
				open_terminal_tab = function() end,
			}
		)

		assert.are.equal("go run /tmp/main.go", calls.cmd)
	end)

	it("opens a new tab and omits env when empty", function()
		local tabs = 0
		local calls
		runner.run(
			{
				command = "echo hi",
				env = {},
				debug = false,
				origin = { file = "/tmp/main.go", ft = "go" },
			},
			{
				spawn = function(cmd, opts)
					calls = { cmd = cmd, opts = opts }
					return 1
				end,
				open_terminal_tab = function()
					tabs = tabs + 1
				end,
			}
		)

		assert.are.equal(1, tabs)
		assert.are.equal("echo hi", calls.cmd)
		assert.is_true(calls.opts.term)
		assert.is_nil(calls.opts.env)
	end)

	it("starts a dap session with the env when debug is set", function()
		local captured
		runner.run(
			{
				command = "ignored",
				env = { TOKEN = "abc" },
				debug = true,
				origin = { file = "/tmp/main.py", ft = "python" },
			},
			{
				dap = {
					run = function(config)
						captured = config
					end,
				},
			}
		)

		assert.are.equal("python", captured.type)
		assert.are.equal("/tmp/main.py", captured.program)
		assert.are.equal("abc", captured.env.TOKEN)
	end)
end)
