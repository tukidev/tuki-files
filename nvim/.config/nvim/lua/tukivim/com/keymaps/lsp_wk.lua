local keymaps = {
    normal_mode = {
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>"      , "Go declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>"       , "Go definition" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>"   , "Go implementation" },
        h = { "<cmd>lua vim.lsp.buf.hover()<CR>"            , "Hover" },
        H = { "<cmd>lua vim.lsp.buf.signature_help()<CR>"   , "Signature" },
        r = { "<cmd>lua vim.lsp.buf.references()<CR>"       , "Reference" },
        j = {
            '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
            'Next err'
        },
        k = {
            '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
            'Prev err'
        },
        l = {
            '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
            "Diagnostic"
        },
    },
}

return keymaps
