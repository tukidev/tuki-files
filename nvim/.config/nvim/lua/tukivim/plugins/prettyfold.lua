import("pretty-fold", function(fold)
	fold.setup({
		sections = {
			left = {
				"+-",
				function()
					return string.rep("-", vim.v.foldlevel * 2 - 5)
				end,
				"content",
				" ---- [ ",
				"number_of_folded_lines",
				" ] ",
			},
			right = {
				"-+ ",
			},
		},
		fill_char = "-", -- variants : ' ' | '•'
		remove_fold_markers = true,
		keep_indentation = false,
		process_comment_signs = "spaces", -- 'delete' | 'spaces' | false
		-- comment_signs = {},

		stop_words = {
			"@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
		},

		add_close_pattern = true, -- true, 'last_line' or false
		matchup_patterns = {
			--- [ lua ]
			{ "^%s*do$", "end" }, -- `do ... end` blocks
			{ "^%s*if", "end" },
			{ "^%s*for", "end" },
			{ "function%s*%(", "end" }, -- 'function(' or 'function ('

			{ "{", "}" },
			{ "%(", ")" }, -- % to escape lua pattern char
			{ "%[", "]" }, -- % to escape lua pattern char
		},

		ft_ignore = { "neorg", "telekasten", "markdown" },
	})
end, {})
