-- TODO: send .g. options to settings/globals
-- TODO: ??? packer lazy loading  ???

require("impatient")

--- [ Globals ]
vim.g.catppuccin_flavour = "mocha" --  latte | frappe | macchiato | mocha

local tukivim = require("tukivim.com")
vim.tukivim = tukivim

tukivim.setup_settings()

require("tukivim.plugins")

tukivim.setup_keymaps()

local commands = require("tukivim.com.commands")
commands.load(commands.defaults)

-- require autocmds
require("tukivim.com.autocmd")
