local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local R = require("tukivim.master.res")
local lsp_path = R.path.config.ide.diagnostic.lsp.p

--require additional lsp plugins
require(lsp_path .. ".lsp-installer")
require(lsp_path .. ".handlers").setup()
