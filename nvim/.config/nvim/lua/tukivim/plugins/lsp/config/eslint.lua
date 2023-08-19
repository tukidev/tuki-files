import("lspconfig", function(lspconfig)
  local handlers = require("tukivim.plugins.lsp.handlers")
  local server_name = "eslint"

  lspconfig[server_name].setup({
    root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,

    settings = {
      format = {
        enable = true,
      },
    },
  })
end)
