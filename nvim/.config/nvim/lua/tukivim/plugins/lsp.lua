local KEYMAPS = require("tukivim.c.keymaps")

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
      { "folke/neodev.nvim",  opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    init = function()
      -- disable lsp watcher. Too slow on linux
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then wf._watchfunc = function() return function() end end end
    end,
    opts = {
      servers = {},
      setup   = {},
    },
    config = function(_, opts)
      require("tukivim.plugins.utils.lsp.config").setup(opts)
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = { nls.builtins.formatting.shfmt },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = KEYMAPS.keys("mason"),
    opts = {
      -- install_root_dir = "/home/tuki/.local/share/nvim/mason",
      ui = {
        width = 0.66,
        height = 0.75,
        icons = {
          package_uninstalled = " ",
          package_installed   = " ",
          package_pending     = " ",
        },
      },
      ensure_installed = {},
    },
    config = function(_, opts)
      require("mason").setup(opts)
      KEYMAPS.load("mason")

      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed       = nil,
      automatic_installation = false,
      automatic_setup        = false,
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    keys = KEYMAPS.keys("trouble"),
    opts = {
      use_diagnostic_signs = true,     -- enabling this will use the signs defined in your lsp client
      position = "bottom",             -- position of the list can be: bottom, top, left, right
      height = 16,                     -- height of the trouble list when position is top or bottom
      width = 50,                      -- width of the list when position is left or right
      action_keys = {
        jump        = { "<cr>", "l" }, -- jump to the diagnostic or open / close folds
        jump_close  = { "<tab>" },     -- jump to the diagnostic or open / close folds
        hover       = { "o" },         -- opens a small popup with the full multiline message
        preview     = { "p" },         -- preview the diagnostic location
        toggle_fold = { "zz" },        -- toggle fold of current file
      },
    },
    config = function(_, opts)
      require("trouble").setup(opts)
      KEYMAPS.load("trouble")
    end
  },
}
