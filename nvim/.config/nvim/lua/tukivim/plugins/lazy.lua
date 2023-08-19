return {
	opts = {
		defaults = { lazy = false },
		dev = {
			path = "~/workspace/dev",
			patterns = { "tuki", "TukiVim" },
		},
		install = {
			missing = true,
			colorscheme = { "catppuccin", "tokyonight", "habamax" },
		},
		checker = { enabled = true },
		diff = { cmd = "git" },
		performance = {
			cache = { enabled = true },
			rtp = {
				disabled_plugins = {
					-- "gzip",
					-- "matchit",
					-- "matchparen",
					-- "netrwPlugin",
					-- "rplugin",
					-- "tarPlugin",
					-- "tohtml",
					-- "tutor",
					-- "zipPlugin",
				},
			},
		},
		ui = {
			-- a number <1 is a percentage., >1 is a fixed size
			size = { width = 0.8, height = 0.8 },
			wrap = true, -- wrap the lines in the ui
			border = "none",
			icons = {
				cmd = " ",
				config = "",
				event = "",
				ft = " ",
				init = " ",
				import = " ",
				keys = " ",
				lazy = "󰒲 ",
				loaded = "●",
				not_loaded = "○",
				plugin = " ",
				runtime = " ",
				source = " ",
				start = "",
				task = "✔ ",
				list = {
					"●",
					"➜",
					"★",
					"‒",
				},
			},
		},
		debug = false,
	},
}
