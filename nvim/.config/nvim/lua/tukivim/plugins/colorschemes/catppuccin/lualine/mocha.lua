local cp = require("catppuccin.palettes").get_palette()
local cp_accent = require("catppuccin.palettes.latte")
-- local ucolors = require("catppuccin.utils.colors")

local monoline = {
  bg = cp.surface0,
  fg = cp.text
}

local theme = {
	mode_colors = {
		n = cp_accent.text,
		i = cp_accent.lavender,
		v = cp_accent.yellow,
		[""] = cp_accent.yellow,
		V = cp_accent.yellow,
		c = cp_accent.maroon,
		no = cp_accent.lavender,
		s = cp_accent.mauve,
		S = cp_accent.mauve,
		[""] = cp_accent.mauve,
		ic = cp_accent.lavender,
		R = cp_accent.red,
		Rv = cp_accent.red,
		cv = cp_accent.yellow,
		ce = cp_accent.yellow,
		r = cp_accent.red,
		rm = cp_accent.red,
		["r?"] = cp_accent.red,
		["!"] = cp_accent.maroon,
		t = cp_accent.maroon,
	},

  line_bg = monoline.bg,
  line_fg = monoline.fg,

  diagnostic = {
    error = monoline,
    warn = monoline,
    info = monoline,
    hint = monoline,
  },

  git = {
    added = monoline,
    removed = monoline,
    modified = monoline,
  }
}

return theme
