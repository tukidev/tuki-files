import("Comment", function(comment)
	comment.setup({
		padding = true,
		sticky = true,
		ignore = nil,
		toggler = {
			line = "gcc",
			block = "gbc",
		},
		opleader = {
			line = "gc",
			block = "gb",
		},
		extra = {
			above = "gcO",
			below = "gco",
			eol = "gcl",
		},
		mappings = {
			basic = true,
			extra = true,
			extended = false,
		},
		pre_hook = nil,
		post_hook = nil,
	})
end)
