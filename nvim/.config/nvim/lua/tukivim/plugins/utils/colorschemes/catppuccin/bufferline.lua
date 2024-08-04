local mocha = require("catppuccin.palettes").get_palette("mocha")

local bg_active = mocha.base
local bg_inactive = mocha.mantle

local base_conf = {
	custom = {
		mocha = {
			-- buffers
			background = { fg = mocha.surface1, bg = bg_inactive },
			buffer_visible = { fg = mocha.surface1, bg = bg_inactive },
			buffer_selected = { fg = mocha.text, bg = bg_active, style = { "bold" } }, -- current
			-- tabs
			tab = { fg = mocha.surface1, bg = bg_inactive },
			tab_selected = { fg = mocha.pink, bg = bg_active },
			tab_close = { fg = mocha.surface1, bg = bg_inactive },
			indicator_selected = { fg = mocha.pink, bg = bg_active },
			-- separators
			separator = { fg = mocha.crust, bg = bg_inactive },
			separator_visible = { fg = mocha.crust, bg = bg_inactive },
			separator_selected = { fg = mocha.crust, bg = bg_inactive },
			offset_separator = { fg = mocha.crust, bg = bg_inactive },
			-- close buttons
			close_button = { fg = mocha.surface1, bg = bg_inactive },
			close_button_visible = { fg = mocha.surface1, bg = bg_inactive },
			close_button_selected = { fg = mocha.pink, bg = bg_active },
			-- Empty fill
			fill = { bg = mocha.mantle },
			-- Modified
			modified = { fg = mocha.surface1, bg = bg_inactive },
			modified_visible = { fg = mocha.surface1, bg = bg_inactive },
			modified_selected = { fg = mocha.pink, bg = bg_active },
			-- Duplicate
		},
	},
}

local function HL()
	local self = {}
	self.highlights = require("catppuccin.groups.integrations.bufferline")
	self.base_conf = base_conf

	self.get = function(conf)
		conf = self.base_conf
		return self.highlights.get(conf)
	end

	return self
end

return HL()

