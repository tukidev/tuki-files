local tukivim = require("tukivim.com")
vim.tukivim = tukivim

tukivim.setup_settings()
require("tukivim.plugins")

tukivim.setup_keymaps()

local commands = require("tukivim.com.commands")
commands.load(commands.defaults)
