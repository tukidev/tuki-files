local R = require("tukivim.master.res")
local CONFIG_PATH = R.path.config

local configurations = {
    'tukivim.plugins',

    'tukivim.plugin-config.options',
    'tukivim.plugin-config.mappings',

    CONFIG_PATH.ui.p,
    CONFIG_PATH.ide.p,
    CONFIG_PATH.opt.p,
}

local function require_configs(configs)
    for _, config in ipairs(configs) do
        require(config)
    end
end

require_configs(configurations)

local commands = require("tukivim.master.commands")
commands.load(commands.defaults)
