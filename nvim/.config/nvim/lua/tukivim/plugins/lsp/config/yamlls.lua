import("lspconfig", function(lspconfig)
  local handlers = require("tukivim.plugins.lsp.handlers")
  local server_name = "yamlls"

  lspconfig[server_name].setup({
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,

    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          -- ["/home/tuki/dev/schemas/yaml/springboot-schema.json"] = "application.yml"
        },
      },
    },
  })
end)
