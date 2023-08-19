local components = require("tukivim.plugins.lualine.theme").components

local M = {}

-- used just 2 sections
-- lualine_c for the right side
-- lualine_x for the left side
M = {
	lualine_a = {
		components.mode,
	},
	lualine_b = {},
	lualine_c = {
		components.File.name,
    components.GIT.branch,
		components.GIT.diff,
	},

	lualine_x = {
    components.LSP.diag,
		components.LSP.name,
		components.File.type,
		components.Carret.percent,
		components.Carret.location,
	},
	lualine_y = {},
	lualine_z = {
		-- components.Carret.percent,
		-- components.Carret.location,
	},
}

return M
