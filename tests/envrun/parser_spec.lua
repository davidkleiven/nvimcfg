local parse = require("custom.envrun.parser").parse

describe("envrun parser", function()
	it("extracts KEY = VALUE into env", function()
		local r = parse({ "PORT = 8080", "WITH_AUTH = 1" })
		assert.are.same({ WITH_AUTH = "1", PORT = "8080" }, r.env)
	end)

	it("treats COMMAND as the command, not an env var", function()
		local r = parse({ "COMMAND = go run ./main.go" })
		assert.is_nil(r.env.COMMAND)
		assert.are.equal("go run ./main.go", r.command)
	end)

	it("sets command to nil when empty", function()
		assert.is_nil(parse({ "COMMAND =" }).command)
	end)

	it("ENVRUN_DEBUG = true enables debug mode", function()
		assert.is_true(parse({ "ENVRUN_DEBUG = true" }).debug)
		assert.is_true(parse({ "ENVRUN_DEBUG = 1" }).debug)
		assert.is_false(parse({ "ENVRUN_DEBUG = false" }).debug)
	end)

	it("DEBUG stays a normal env var (for logging)", function()
		local r = parse({ "DEBUG = 1" })
		assert.are.equal("1", r.env.DEBUG)
		assert.is_false(r.debug)
	end)

	it("ignores lines without an '='", function()
		local r = parse({ "ENVRUN = 1", "not_a_pair" })
		assert.are.same({ ENVRUN = "1" }, r.env)
	end)
end)
