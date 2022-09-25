import("null-ls", function(null_ls)
	null_ls.setup({
		sources = {
			--- [ Lua ]
			null_ls.builtins.formatting.stylua,
			-- null_ls.builtins.diagnostics.luacheck,

			--- [ Tex / LaTex ]
			-- null_ls.builtins.formatting.latexindent,
			-- null_ls.builtins.diagnostics.chktex,

			--- [ Git ]
			null_ls.builtins.code_actions.gitsigns,

			--- [ Shells ]
			null_ls.builtins.diagnostics.zsh,
			null_ls.builtins.diagnostics.shellcheck,
			null_ls.builtins.code_actions.shellcheck,

			--- [ Java ]
			null_ls.builtins.formatting.google_java_format,

			--- [ * ]
			-- null_ls.builtins.completion.spell,
		},
	})
end)
