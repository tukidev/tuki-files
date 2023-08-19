import("typescript", function(tsserver)
  local handlers = require("tukivim.plugins.lsp.handlers")

  tsserver.setup({
    server = {
      capabilities = handlers.defaults.capabilities,
      on_attach = function (client, bufnr)
        handlers.defaults.on_attach(client, bufnr)
        vim.tukivim.keymaps.load_module_wk("typescript", bufnr)
      end
    },
  })
end)
