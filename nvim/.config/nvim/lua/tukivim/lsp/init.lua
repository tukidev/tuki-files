local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("tukivim.lsp.lsp-installer")
require("tukivim.lsp.handlers").setup()
-- require("tukivim.lsp.null-ls")
