local keymaps = {
    normal_mode = {
        ["fD"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
        ["fd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
        ["fi"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
        ["fH"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        ["fr"] = "<cmd>lua vim.lsp.buf.references()<CR>",
        ["fl"] = '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',

        ["fh"]  = "<cmd>lua vim.lsp.buf.hover()<CR>",

        ["[d"] = '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
        ["]d"] = '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',

        ["<leader>q"] = "<cmd>lua vim.diagnostic.setloclist()<CR>",

    }
}

local loader = require("tukivim.com.keymaps.loader").setup()
loader.setup(keymaps)
return loader
