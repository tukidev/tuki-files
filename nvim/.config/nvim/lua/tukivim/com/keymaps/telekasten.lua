local telekasten = require("telekasten")

return {
	normal_mode = {
		["<C-Enter>"] = telekasten.follow_link,
		["<C-Space>"] = telekasten.toggle_todo,
		["yz"] = telekasten.yank_notelink,
		["pz"] = telekasten.insert_notelink,
		["zl"] = telekasten.find_friends,
		["zL"] = telekasten.show_backlinks,
	},
	insert_mode = {
		["<C-Space>"] = function() telekasten.toggle_todo({ i = true }) end,
	},
}
