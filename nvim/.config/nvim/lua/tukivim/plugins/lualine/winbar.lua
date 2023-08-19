local components = require("tukivim.plugins.lualine.theme").components

local M = {}

-- used just 2 sections
-- lualine_c for the right side
-- lualine_x for the left side
M = {
	lualine_a = {},
	lualine_b = {},
	lualine_y = {},
	lualine_z = {},

	lualine_c = {
    components.winbar.file,
    components.winbar.navic,
	},

	lualine_x = {
    -- components.winbar.diag,
    -- components.winbar.diag_ok
	},
}

return M
