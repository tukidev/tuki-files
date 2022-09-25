import("notify", function(notify)
	notify.setup({
		stages = "fade", -- Animation style (see below for details)
		render = "default", -- Render function for notifications. See notify-render()
		timeout = 6000, -- Default timeout for notifications
		on_open = nil, -- Function called when a new window is opened, use for changing win settings/config
		on_close = nil, -- Function called when a window is closed
		max_width = nil,
		max_height = nil,
		minimum_width = 50,

		background_colour = "Normal", -- a highlight group | an RGB hex | a function

		icons = vim.tukivim.res.icons.notify,
	})

	vim.notify = notify
end)
