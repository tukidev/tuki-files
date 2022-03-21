vim.tukivim.register("lspconfig")

local lsp_path = vim.tukivim.res.path.config.ide.diagnostic.lsp.p

--require additional lsp plugins
require(lsp_path .. ".handlers").setup()
require(lsp_path .. ".lsp-installer")
require(lsp_path .. ".saga")
