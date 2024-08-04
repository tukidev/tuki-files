if not require("tukivim.c").pde["python"] then
  return {}
end

local KEYMAPS = require("tukivim.c.keymaps")
local UTILS = require("tukivim.c.utils")

local pde_ft = "python"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      -- formatters
      table.insert(opts.sources, nls.builtins.formatting.black)
      -- static analysis
      table.insert(opts.sources, nls.builtins.diagnostics.mypy.with({
        extra_args = function()
          local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
          return { "--python-executable", virtual .. "/bin/python3" }
        end,
      }))
      -- table.insert(opts.sources, nls.builtins.diagnostics.ruff)
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   optional = true,
  --   dependencies = { "lukas-reineke/cmp-under-comparator" },
  --   opts = function(_, opts)
  --     local compare = require("cmp.config.compare")
  --     return vim.tbl_deep_extend("force", {
  --       sorting = {
  --         comparators = {
  --           compare.offset,
  --           compare.exact,
  --           compare.score,
  --           require("cmp-under-comparator").under,
  --           compare.recently_used,
  --           compare.kind,
  --           compare.sort_text,
  --           compare.length,
  --           compare.order,
  --         }
  --       }
  --     }, opts)
  --   end
  -- },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- "pyright",
        "debugpy",
        "black",
        -- "ruff",
        -- "mypy"
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["ruff_lsp"] = {},
        ["pyright"] = {
          capabilities = (function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            return capabilities
          end)(),
          settings = {
            python = {
              disableOrganizeImports = true,
              analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs/stubs",
              },
            },
          },
        },
      },
      setup = {
        ["ruff_lsp"] = function()
          UTILS.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
        ["pyright"] = function()
          UTILS.on_attach(function(client, bufnr)
            if client.name == "pyright" then
              UTILS.keys_on_lazy_ft("nvim-dap-python", pde_ft, "dap-python")
              KEYMAPS.load("lsp-python", bufnr)
            end
          end)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
      KEYMAPS.load("dap-python")
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-python" },
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = { justmycode = false },
          runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
  { "microsoft/python-type-stubs", ft = "python" },
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   ft = "python",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   cmd = "VenvSelect",
  --   keys = KEYMAPS.keys("venv-selector"),
  --   opts = {
  --     name = { "envs", "venv", ".venv", "env", ".env" },
  --     anaconda_envs_path = "~/anaconda3/envs"
  --   },
  --   config = function(_, opts)
  --     require("venv-selector").setup(opts)
  --     KEYMAPS.load("venv-selector")
  --   end
  -- },
}
