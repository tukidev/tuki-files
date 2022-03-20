local keymaps = {
    normal_mode = {
        -- LSP
        ["gD"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
        ["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
        ["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
        ["gi"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
        ["gh"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        ["<leader>rn"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
        ["gr"] = "<cmd>lua vim.lsp.buf.references()<CR>",
        ["<leader>ca"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
        ["<leader>f"] = "<cmd>lua vim.diagnostic.open_float()<CR>",
        ["[d"] = '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
        ["gl"] = '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
        ["]d"] = '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
        ["<leader>q"] = "<cmd>lua vim.diagnostic.setloclist()<CR>",
        -- [""] = "",
    },
}


return require("tukivim.master.defaults.keymappings.obj").setup(keymaps)
