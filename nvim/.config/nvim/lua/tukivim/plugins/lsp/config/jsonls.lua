import("lspconfig", function(lspconfig)
  local handlers = require("tukivim.plugins.lsp.handlers")
  local server_name = "jsonls"

  lspconfig[server_name].setup({
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,

    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
end)
