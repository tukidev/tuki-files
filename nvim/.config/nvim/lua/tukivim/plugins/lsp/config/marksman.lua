import("lspconfig", function(lspconfig)
  local handlers = require("tukivim.plugins.lsp.handlers")
  local server_name = "marksman"

  lspconfig[server_name].setup({
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,
  })
end)
