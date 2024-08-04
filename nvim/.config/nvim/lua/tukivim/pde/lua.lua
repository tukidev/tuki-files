if not require("tukivim.c").pde.lua then
  return {}
end

local UTILS = require("tukivim.c.utils")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
    end,
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, { "stylua" })
  --   end,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     table.insert(opts.sources, nls.builtins.formatting.stylua)
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
        },
      },
    },
    opts = {
      servers = {
        ["lua_ls"] = {
          settings = {
            Lua = {
              workspace   = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
              completion  = { callSnippet = "Replace" },
              telemetry   = { enable = false },
              hint        = { enable = false },
              runtime     = { version = 'LuaJIT' },
              diagnostics = {
                disable = { "incomplete-signature-doc" },
                globals = { "vim" },
              },
              format      = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      setup = {
        ["lua_ls"] = function(_, _)
          UTILS.on_attach(function(client, buffer)
          end)
        end,
      },
    },
  },
  -- Debugging
  --[[
  {
    "mfussenegger/nvim-dap",
    dependencies = { "jbyuki/one-small-step-for-vimkind" },
    opts = {
      setup = {
        osv = function(_, _)
          local dap = require("dap")
          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance",
              host = function()
                local value = vim.fn.input "Host [127.0.0.1]: "
                if value ~= "" then
                  return value
                end
                return "127.0.0.1"
              end,
              port = function()
                local val = tonumber(vim.fn.input("Port: ", "8086"))
                assert(val, "Please provide a port number")
                return val
              end,
            },
          }

          dap.adapters.nlua = function(callback, config)
            callback { type = "server", host = config.host, port = config.port }
          end
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-plenary" },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, { require("neotest-plenary") })
    end,
  },
  --]]

}
