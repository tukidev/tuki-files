local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local lsp_folder = "tukivim.plugin-config.lsp."

require(lsp_folder .. "lsp-installer")
require(lsp_folder .. "handlers").setup()
-- require("tukivim.lsp.null-ls")
