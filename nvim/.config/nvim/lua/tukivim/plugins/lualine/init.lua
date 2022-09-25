import("lualine", function(lualine)
	local theme = require("tukivim.plugins.lualine.theme")

	local options = {
		icons_enabled = true,
		theme = theme.theme,
		always_divide_middle = true,
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha" },
	}

	lualine.setup({
		options = options,
		sections = theme.sections,
	})
end)
