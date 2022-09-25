local handlers = require("tukivim.plugins.lsp.handlers")

local servers = {
  ["sumneko_lua"] = {
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          -- library = vim.api.nvim_get_runtime_file("", true),
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },

  --[[
  ["rust_analyzer"] = {
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,
    tools = {
      on_initialized = function()
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
          pattern = { "*.rs" },
          callback = function()
            vim.lsp.codelens.refresh()
          end,
        })
      end,
      inlay_hints = {
        parameter_hints_prefix = " ",
        other_hints_prefix = " ",
      },
    },
    settings = {
      ["rust-analyzer"] = {
        cargo = { autoReload = true },
      },
    },
  },
  --]]

  -- ["jdtls"] = {}, -- INFO: using plugin `mfussenegger/nvim-jdtls` instead

  ["pyright"] = {
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,
  },

  ["marksman"] = {
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,
  },

  ["jsonls"] = {
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,
  },

  ["cssls"] = {
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,
  },

  ["lemminx"] = {
    capabilities = handlers.defaults.capabilities,
    on_attach = handlers.defaults.on_attach,
  },
}

return servers
