local R = require("tukivim.com.res")

local defaults = {}

defaults.res = R
defaults.utils    = require(R.path.com.utils.p)
defaults.settings = require(R.path.com.settings.p)
defaults.cmd      = require(R.path.com.commands.p)
defaults.keymaps  = require(R.path.com.keymaps.p)

function TVim()
    local self = {}
    self.res      = defaults.res
    self.utils    = defaults.utils
    self.settings = nil
    self.keymaps  = nil
    self.cmd      = nil
    self.plugins  = nil


    ---Loads keymaps of inputs or default keymaps if param is empty 
    -- @param keymaps : instance of keymaps class with a propriate structure
    function self.set_keymaps(keymaps)
        self.keymaps = keymaps or defaults.keymaps      -- TODO: add exception handling
        self.keymaps.load()
    end


    ---Loads settings of inputs or default settings if param is empty 
    -- @param settings : instance of settings class with a propriate structure
    function self.setup_settings(settings)
        self.settings = settings or defaults.settings   -- TODO: add exception handling
        self.settings.load()
    end


    ---Loads commands of inputs or default commands if param is empty 
    -- @param commands : instance of commands class with a propriate structure
    function self.set_commands(commands)
        self.cmd = keymaps or defaults.cmd              -- TODO: add exception handling
        self.cmd.load()
    end


    ---Adds param plugin to plugin's table with index to simplifier access
    -- @param index : index to plugin's table
    -- @param plugin : plugin module
    function self.register_plugin(index, plugin)
        self.plugins[index] = plugin
    end


    return self
end
