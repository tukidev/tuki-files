import("null-ls", function(null_ls)
	local b = null_ls.builtins
	null_ls.setup({
		sources = {
			--- [ Lua ]
			b.formatting.stylua,
			-- b.diagnostics.luacheck,

			--- [ Tex / LaTex ]
			-- b.formatting.latexindent,
			-- b.diagnostics.chktex,

			--- [ Git ]
			b.code_actions.gitsigns,

			--- [ Shells ]
			b.diagnostics.zsh,
			b.diagnostics.shellcheck,
			b.code_actions.shellcheck,

			--- [ Java ]
			-- b.formatting.google_java_format.with({
			-- 	extra_args = { "-a" },
			-- }),

			--- [ TypeScript ]
			require("typescript.extensions.null-ls.code-actions"),

			--- [ * ]
			-- b.completion.spell,
		},
	})
end)
