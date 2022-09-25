import("telekasten", function(telekasten)
	local home = vim.fn.expand("~/me/tkorg")

	telekasten.setup({
		home = home,

		-- if true, telekasten will be enabled when opening a note within the configured home
		take_over_my_home = true,

		-- auto-set telekasten filetype: if false, the telekasten filetype will not be used
		--                               and thus the telekasten syntax will not be loaded either
		auto_set_filetype = true,

		-- dir names for special notes (absolute path or subdir name)
		dailies = home .. "/" .. "journal/daily",
		weeklies = home .. "/" .. "journal/weekly",
		templates = home .. "/" .. "journal/templates",

		-- image (sub)dir for pasting
		-- dir name (absolute path or subdir name)
		-- or nil if pasted images shouldn't go into a special subdir
		image_subdir = "img",

		-- markdown file extension
		extension = ".md",

		-- Generate note filenames. One of:
		-- "title" (default) - Use title if supplied, uuid otherwise
		-- "uuid" - Use uuid
		-- "uuid-title" - Prefix title by uuid
		-- "title-uuid" - Suffix title with uuid
		new_note_filename = "title",

		-- file uuid type ("rand" or input for os.date()")
		uuid_type = "%Y%m%d%H%M",

		-- UUID separator
		uuid_sep = "-",

		-- following a link to a non-existing note will create it
		follow_creates_nonexisting = true,
		dailies_create_nonexisting = true,
		weeklies_create_nonexisting = true,

		-- skip telescope prompt for goto_today and goto_thisweek
		journal_auto_open = false,

		-- template for new notes (new_note, follow_link)
		-- set to `nil` or do not specify if you do not want a template
		template_new_note = home .. "/" .. "/journal/templates/new_note.md",

		-- template for newly created daily notes (goto_today)
		-- set to `nil` or do not specify if you do not want a template
		template_new_daily = home .. "/" .. "/journal/templates/daily.md",

		-- template for newly created weekly notes (goto_thisweek)
		-- set to `nil` or do not specify if you do not want a template
		template_new_weekly = home .. "/" .. "/journal/templates/weekly.md",

		-- wiki:     ![[image name]]
		-- markdown: ![](image_subdir/xxxxx.png)
		image_link_style = "markdown",

		-- default sort option: 'filename', 'modified'
		sort = "filename",

		-- integrate with calendar-vim
		plug_into_calendar = true,

		-- telescope actions behavior
		close_after_yanking = false,
		insert_after_inserting = true,

		-- tag notation: '#tag', ':tag:', 'yaml-bare'
		tag_notation = { "#tag", "yaml-bare" },

		-- command palette theme: dropdown (window) or ivy (bottom panel)
		command_palette_theme = "dropdown",

		-- tag list theme:
		-- get_cursor: small tag list at cursor; ivy and dropdown like above
		show_tags_theme = "dropdown",

		-- when linking to a note in subdir/, create a [[subdir/title]] link
		-- instead of a [[title only]] link
		subdirs_in_links = true,
		template_handling = "smart",
		new_note_location = "smart",

		-- should all links be updated when a file is renamed
		rename_update_links = true,
	})

	vim.tukivim.keymaps.load_module_wk("telekasten_wk", " ", nil)
	vim.tukivim.keymaps.load_module("telekasten")
end)
