import("neodim", function(neodim)
	neodim.setup({
		alpha = 0.50,
		blend_color = require("catppuccin.palettes").get_palette().base,
		update_in_insert = {
			enable = true,
			delay = 100,
		},
		hide = {
			virtual_text = true,
			signs = false,
			underline = true,
		},
	})
end)
