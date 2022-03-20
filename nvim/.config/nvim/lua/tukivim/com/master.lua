function TVim()
    local self = {}
    self.res = require("tukivim.com.res"),
    self.utils = require("tukivim.com.source.utils"),
    self.settings = nil,
    self.keymaps = nil,
    self.cmd = nil
    self.plugins = nil,


    function self.setup()
        self.settings.load()
        self.keymaps.load()
        self.cmd.load()
    end


    function self.set_keymaps(keymaps)
        self.keymaps = keymaps or nil       -- TODO: add exception handling
        self.keymaps.load()
    end


    function self.setup_settings(settings)
        self.settings = settings or {}      -- TODO: add exception handling
        self.settings.load()
    end


    function self.set_commands(commands)
        self.cmd = keymaps or nil           -- TODO: add exception handling
        self.cmd.load()
    end


    function self.register_plugin(index, plugin)
        self.plugins[index] = plugin
    end


    return self
end
