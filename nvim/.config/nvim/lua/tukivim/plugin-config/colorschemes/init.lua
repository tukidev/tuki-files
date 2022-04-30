local scheme_default = "catppuccin"

---Colorscheme wrapper to make scheme's choosing easier
function ColorScheme()
	local self = {}
	self.scheme = scheme_default

	local function apply()
		pcall(require, "tukivim.plugin-config.colorschemes." .. self.scheme)
	end

	function self.set(colorscheme)
		self.scheme = colorscheme
		apply()
	end

	return self
end

return ColorScheme()
