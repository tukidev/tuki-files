local R = require("tukivim.com.res")

local defaults = {}
defaults.res = R
defaults.utils = require(R.path.com.src.utils.p)
defaults.settings = require(R.path.com.settings.p)
defaults.cmd = require(R.path.com.commands.p)
defaults.keymaps = require(R.path.com.keymaps.p)

function TukiVim()
	local self = {}
	self.res = defaults.res
	self.utils = defaults.utils
	self.keymaps = defaults.keymaps

	---Loads keymaps of inputs or default keymaps if param is empty
	---@param keymaps table [opt] instance of keymaps class with a propriate structure
	function self.setup_keymaps(keymaps)
		self.keymaps = keymaps or defaults.keymaps -- TODO: add exception handling
		self.keymaps.load()
	end

	---Loads settings of inputs or default settings if param is empty
	-- @param settings [opt] : instance of settings class with a propriate structure
	function self.setup_settings(settings)
		self.settings = settings or defaults.settings -- TODO: add exception handling
		self.settings.load()
	end

	---Loads commands of inputs or default commands if param is empty
	-- @param commands [opt] : instance of commands class with a propriate structure
	function self.setup_commands(commands)
		self.cmd = commands or defaults.cmd -- TODO: add exception handling
		self.cmd.load()
	end

  require("tukivim.com.source.neoman").init()
	return self
end

return TukiVim()
