local R = require("tukivim.com.res")
local PATH = R.path

local configurations = {
    'tukivim.plugins',

    'tukivim.plugin-config.options',
    -- 'tukivim.plugin-config.mappings',

    PATH.config.ui.p,
    PATH.config.ide.p,
    PATH.config.opt.p,
}

local function require_configs(configs)
    for _, config in ipairs(configs) do
        require(config)
    end
end


require(PATH.com.defaults.keymap.p).load()       -- setup keymaps


require_configs(configurations)

local commands = require("tukivim.com.commands")
commands.load(commands.defaults)
