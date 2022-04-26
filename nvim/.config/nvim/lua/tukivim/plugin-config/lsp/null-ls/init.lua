local null_ls = vim.tukivim.utils.psetup("null-ls")


local conf = {
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,

        -- tex/latex
        null_ls.builtins.formatting.latexindent,
        null_ls.builtins.diagnostics.chktex,
    },
}

null_ls.setup(conf)

return null_ls
