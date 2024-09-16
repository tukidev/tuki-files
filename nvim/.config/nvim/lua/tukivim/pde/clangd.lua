if not require("tukivim.c").pde["clangd"] then
  return {}
end

KEYMAPS = require("tukivim.c.keymaps")


return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cpp" } },
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end, -- remove default `require('clangd_extensions').setup()`
    opts = {
      inlay_hints = { inline = false },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },

  -- Correctly setup lspconfig for clangd 
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        ["clangd"] = {
          keys = {
            { "<leader>lz", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            { "<leader>lh", "<cmd>ClangdToggleInlayHints<cr>",   desc = "Toggle inlay [h]ints" }
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=google",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
      setup = {
        ["clangd"] = function(_, opts)
          local clangd_ext_opts = TukiVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          KEYMAPS.load("lsp-clang")
          return false
        end,
      },
    },
  },
  {
    "nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sorting.comparators, 3, require("clangd_extensions.cmp_scores"))
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "williamboman/mason.nvim",
      optional = true,
      opts = { ensure_installed = { "codelldb" } },
    },
    opts = function()
      local dap = require("dap")
      if not dap.adapters["codelldb"] then
        require("dap").adapters["codelldb"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = {
              "--port",
              "${port}",
            },
          },
        }
      end
      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            pid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     optional = true,
  --     opts = { ensure_installed = { "clang-format" } },
  --   },
  --   optional = true,
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     local h = require("null-ls.helpers")
  --     table.insert(
  --       opts.sources,
  --       nls.builtins.formatting.clang_format.with({
  --         filetypes = { "c", "cpp", "cuda", "proto" },
  --         command = "clang-format",
  --         -- args = {
  --         --   "-assume-filename", "$FILENAME",
  --         --   "-style", "{BasedOnStyle: InheritParentConfig, IndentWidth: 4}",
  --         -- }
  --         args = h.range_formatting_args_factory(
  --           {
  --             "-assume-filename", "$FILENAME",
  --             "-style", "{BasedOnStyle: google, IndentWidth: 4}",
  --           },
  --           "--offset",
  --           "--length",
  --           { use_length = true, row_offset = -1, col_offset = -1 }
  --         ),
  --       })
  --     )
  --   end,
  -- },
}
