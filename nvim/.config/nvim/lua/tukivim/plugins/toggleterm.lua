import("toggleterm", function(term)
	-- TODO: universal theme module
	local cp = require("catppuccin.palettes").get_palette()

	term.setup({
		size = 20,
		open_mapping = [[<C-t>]],
		hide_numbers = true,
		shade_filetypes = {},
		highlights = {
			Normal = {
				guibg = cp.crust,
			},
			NormalFloat = {
				guibg = cp.crust,
			},
			FloatBorder = {
				guifg = cp.crust,
				guibg = cp.crust,
			},
		},
		shade_terminals = false,
		shading_factor = 1, -- default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		persist_size = true,
		persist_mode = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "single", -- 'single', | 'double' | 'shadow' | 'curved' | ... other options supported by win open
			width = 120,
			height = 30,
			winblend = 3,
		},
	})
end)
