local tukivim = require("tukivim.com")
vim.tukivim = tukivim                       -- HACK: builtin own module into vim

tukivim.setup_settings()
tukivim.setup_keymaps()

require("tukivim.plugins")
require('tukivim.plugin-config.colorschemes').set("catppuccin")


local commands = require("tukivim.com.commands")
commands.load(commands.defaults)
