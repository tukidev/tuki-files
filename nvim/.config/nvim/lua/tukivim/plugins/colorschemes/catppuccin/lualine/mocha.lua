local cp = require("catppuccin.palettes").get_palette()

local lineBaseCP = {
	statusline = {
		bg = cp.mantle,
		fg = cp.overlay2,
	},
	winbar = {
		bg = nil,
		fg = cp.overlay2,
	},
}

local T = {}

T.line_bg = lineBaseCP.statusline.bg
T.line_fg = lineBaseCP.statusline.fg

T.winbar = {
	diagnostic = {
		error = "DiagnosticVirtualTextError",
		warn = "DiagnosticVirtualTextWarn",
		info = "DiagnosticVirtualTextInfo",
		hint = "DiagnosticVirtualTextHint",
		-- error = { fg = cp.red, bg = cp.base },
		-- warn = { fg = cp.yellow, bg = cp.base },
		-- info = { fg = cp.sky, bg = cp.base },
		-- hint = { fg = cp.teal, bg = cp.base },
	},
}

T.theme = {
	normal = {
		a = { fg = cp.overlay0, bg = lineBaseCP.statusline.bg },
    b = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		c = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },

		x = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },
    y = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		z = { fg = lineBaseCP.fg, bg = lineBaseCP.statusline.bg },
	},
	insert = {
		a = { fg = cp.lavender, bg = lineBaseCP.statusline.bg },
    b = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		c = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },

		x = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },
    y = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		z = { fg = cp.mantle, bg = lineBaseCP.statusline.bg },
	},
	visual = {
		a = { fg = cp.sky, bg = lineBaseCP.statusline.bg },
    b = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		c = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },

		x = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },
    y = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		z = { fg = cp.mantle, bg = lineBaseCP.statusline.bg },
	},
	replace = {
		a = { fg = cp.red, bg = lineBaseCP.statusline.bg },
    b = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		c = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },

		x = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },
    y = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		z = { fg = cp.mantle, bg = lineBaseCP.statusline.bg },
	},
	command = {
		a = { fg = cp.peach, bg = lineBaseCP.statusline.bg },
    b = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		c = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },

		x = { fg = lineBaseCP.statusline.fg, bg = lineBaseCP.statusline.bg },
    y = { fg = lineBaseCP.winbar.fg, bg = lineBaseCP.winbar.bg },
		z = { fg = cp.mantle, bg = lineBaseCP.statusline.bg },
	},
}

T.diagnostic = {
	-- error = lineBaseCP.statusline,
	-- warn = lineBaseCP.statusline,
	-- info = lineBaseCP.statusline,
	-- hint = lineBaseCP.statusline,

	error = { fg = cp.red },
	warn = { fg = cp.yellow },
	info = { fg = cp.blue },
	hint = { fg = cp.sky },
}

T.git = {
	-- added = lineBaseCP.statusline,
	-- removed = lineBaseCP.statusline,
	-- modified = lineBaseCP.statusline,

	added = { fg = cp.text },
	removed = { fg = cp.maroon },
	modified = { fg = cp.surface2 },
}

return T
