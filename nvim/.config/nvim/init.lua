local tukivim = require("tukivim.com")
tukivim.setup_settings()
tukivim.setup_keymaps()

vim.tukivim = tukivim       -- HACK: builtin own module into vim


local PATH = tukivim.res.path
local configs = {
    'tukivim.plugins',

    PATH.config.ui.p,
    PATH.config.ide.p,
    PATH.config.opt.p,
}

tukivim.utils.req_list(configs)

local commands = require("tukivim.com.commands")
commands.load(commands.defaults)
