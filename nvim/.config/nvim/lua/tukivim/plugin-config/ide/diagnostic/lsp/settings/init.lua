local PATH = vim.tukivim.res.path.config.ide.diagnostic.lsp.p .. ".settings"

return {
    sumneko_lua = require(PATH .. ".sumneko_lua")
}
