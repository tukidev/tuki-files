local tukivim = require("tukivim.com")
vim.tukivim = tukivim                       -- HACK: builtin own module into vim

tukivim.setup_settings()

require("tukivim.plugins")
require('tukivim.plugin-config.colorschemes').set("catppuccin")

tukivim.setup_keymaps()

local commands = require("tukivim.com.commands")
commands.load(commands.defaults)
