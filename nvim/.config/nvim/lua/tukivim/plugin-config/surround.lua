vim.tukivim.utils.psetup("surround", {
	context_offset = 100,
	load_autogroups = false,
	mapings_style = "sandwich",
	map_insert_mode = false,
	quotes = { "'", '"' },
	brackets = { "(", "{", "[" },
	space_on_closing_char = false,
	pairs = {
		prefix = "s",
		nestable = {
			["("] = { "(", ")" },
			["["] = { "[", "]" },
			["{"] = { "{", "}" },
			["<"] = { "<", ">" },
		},
		linear = {
			["'"] = { "'", "'" },
			['"'] = { '"', '"' },
			["`"] = { "`", "`" },
		},
	},
})
