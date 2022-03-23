local keymaps = {
    normal_mode = {
        ["gD"] =  "<cmd>lua vim.lsp.buf.declaration()<CR>",
        ["gd"] =  "<cmd>lua vim.lsp.buf.definition()<CR>",
        ["gi"] =  "<cmd>lua vim.lsp.buf.implementation()<CR>",
        ["gh"] =  "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        ["gr"] =  "<cmd>lua vim.lsp.buf.references()<CR>",
        ["gl"] =  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',

        ["K"]  =  "<cmd>lua vim.lsp.buf.hover()<CR>",

        ["[d"] =  '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
        ["]d"] =  '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',

        ["<leader>q"] =  "<cmd>lua vim.diagnostic.setloclist()<CR>",

    }
}


return keymaps          -- TODO: return loader module
