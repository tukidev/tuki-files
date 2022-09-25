import("possession", function(possession)
	possession.setup({
		-- session_dir = (Path:new(vim.fn.stdpath("data")) / "possession"):absolute(),
		session_dir = vim.fn.stdpath("data") .. "/possession",
		silent = true,
		load_silent = true,
		debug = false,
		prompt_no_cr = true,
		autosave = {
			current = true, -- or fun(name): boolean
			tmp = true, -- or fun(): boolean
			tmp_name = "- last session -",
			on_load = true,
			on_quit = true,
		},
		commands = {
			save = "SesSave",
			load = "SesLoad",
			close = "SesClose",
			delete = "SesDelete",
			show = "SesShow",
			list = "SesList",
			migrate = "SesMigrate",
		},
		plugins = {
			close_windows = {
				hooks = { "before_save", "before_load" },
				preserve_layout = true, -- or fun(win): boolean
				match = {
					floating = true,
					buftype = {},
					filetype = {},
					custom = false, -- or fun(win): boolean
				},
			},
			delete_hidden_buffers = {
				hooks = {
					"before_load",
					vim.o.sessionoptions:match("buffer") and "before_save",
				},
				force = false, -- or fun(buf): boolean
			},
			nvim_tree = true,
			tabby = true,
			delete_buffers = true,
		},
	})
end)
