vim.tukivim.utils.psetup("zen-mode", {
	window = {
		backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
		width = 80,
		height = 1,

		options = {
			number = false, -- disable number column
			-- relativenumber = false,  -- disable relative numbers
			-- signcolumn = "no",       -- disable signcolumn
			-- cursorline = false,      -- disable cursorline
			-- cursorcolumn = false,    -- disable cursor column
			-- foldcolumn = "0",        -- disable fold column
			-- list = false,            -- disable whitespace characters
		},
	},

	plugins = {

		-- disable some global vim options (vim.o...)
		options = {
			enabled = true,
			ruler = false, -- disables the ruler text in the cmd line area
			showcmd = false, -- disables the command in the last line of the screen
		},

		gitsigns = { enabled = false },
		twilight = { enabled = false },
		tmux = { enabled = false }, -- disables the tmux statusline

		-- this will change the font size on kitty when in zen mode
		-- to make this work, you need to set the following kitty options:
		-- - allow_remote_control socket-only
		-- - listen_on unix:/tmp/kitty
		kitty = {
			enabled = false,
			font = "+4",
		},
	},

	-- callback where you can add custom code when the Zen window opens
	on_open = function(win) end,

	-- callback where you can add custom code when the Zen window closes
	on_close = function() end,
})
