local telekasten = require("telekasten")

return {
	normal_mode = {
		z = {
			name = "Notes",

			n = { telekasten.new_note, "New Note" },
			N = { telekasten.new_templated_note, "New Template" },
			e = { telekasten.goto_today, "Goto Today" },
			w = { telekasten.goto_thisweek, "Goto Week" },
			p = { telekasten.panel, "Panel" },
			r = { telekasten.rename_note, "Rename" },
			f = { telekasten.follow_link, "Follow" },
			l = { telekasten.insert_link, "Link" },
			y = { telekasten.yank_notelink, "Yank" },
		},

		f = {
			name = "Find",

			n = { telekasten.find_notes, "Notes" },
			N = { telekasten.search_note, "Search" },
			e = { telekasten.find_daily_notes, "Daily" },
			w = { telekasten.find_weekly_notes, "Weekly" },
			t = { telekasten.show_tags, "Tags" },
		},
	},
}
