function Loader(init)
	local self = {}
	self.config = {}

	function self.setup(config)
		self.config = config or {}
		return self
	end

	function self.load()
		for opt, val in pairs(self.config) do
			vim.opt[opt] = val
		end
	end

	self.setup(init)
	return self
end

return Loader()
