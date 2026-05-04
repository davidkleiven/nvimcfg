return {
	name = 'opencode',
	filetypes = nil,
	cmd = function(dispatchers, config)
		return {
			request = function(method, params, callback)
				-- opencode LSP handlers would go here
			end,
			notify = function() end,
			is_closing = function() return false end,
			terminate = function() end,
		}
	end,
}
