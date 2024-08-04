if not require("tukivim.c").pde["rust"] then
  return {}
end


local UTILS = require("tukivim.c.utils")

local function get_codelldb()
  local mason_registry = require("mason-registry")
  local codelldb       = mason_registry.get_package("codelldb")
  local extension_path = codelldb:get_install_path() .. "/extension/"
  local codelldb_path  = extension_path .. "adapter/codelldb"
  local liblldb_path   = extension_path .. "lldb/lib/liblldb.so"
  return codelldb_path, liblldb_path
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb", "rust-analyzer" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Rust LSP extension
      {
        "simrat39/rust-tools.nvim",
        lazy = true,
        opts = function()
          local codelldb_path, liblldb_path = get_codelldb()
          return {
            dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
            tools = {
              on_initialized = function()
                vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
              end,
            },
          }
        end,
        config = function() end,
      }
    },
    opts = {
      servers = {
        ["rust_analyzer"] = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                autoReload = true,
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        ["taplo"] = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          UTILS.on_attach(function(client, bufnr)
            if client.name == "rust_analyzer" then
              require("tukivim.plugins.utils.lsp").on_attach(client, bufnr)
              require("tukivim.c.keymaps").load("lsp-rust", bufnr)
            end
          end)

          vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = { "Cargo.toml" },
            callback = function(event)
              local bufnr = event.buf
              require("tukivim.c.keymaps").load("crates", bufnr)
            end,
          })

          ---@diagnostic disable-next-line:redundant-parameter
          require("rust-tools").setup(
            vim.tbl_deep_extend("force", UTILS.opts("rust-tools.nvim") or {}, { server = opts }))

          return true
        end,
      },
    },
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
      popup = { border = "rounded" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "Saecki/crates.nvim" },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(
        vim.list_extend(opts.sources, { { name = "crates" } }))
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "rouge8/neotest-rust" },
    opts = {
      adapters = { ["neotest-rust"] = {} },
    },
  },
}
