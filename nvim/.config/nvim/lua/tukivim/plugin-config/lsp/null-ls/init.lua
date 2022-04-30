local null_ls = vim.tukivim.utils.psetup("null-ls")

local conf = {
	sources = {
		--- [ Lua ]
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.luacheck,

		--- [ Tex / LaTex ]
		null_ls.builtins.formatting.latexindent,
		null_ls.builtins.diagnostics.chktex,

        --- [ Git ]
        null_ls.builtins.code_actions.gitsigns,

        --- [ * ]
		null_ls.builtins.completion.spell,
	},
}

null_ls.setup(conf)

return null_ls
