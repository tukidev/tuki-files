-- vim.tukivim.register("lspconfig")
--
-- --require additional lsp plugins
-- require(PATH .. ".handlers").setup()
-- require(PATH .. ".lsp-installer")
-- require(PATH .. ".saga")

local PATH = vim.tukivim.res.path.config.ide.diagnostic.lsp.p
vim.tukivim.register(PATH .. ".module", {})