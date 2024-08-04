local UTILS = require("tukivim.c.utils")
local ICONS = require("tukivim.c.res.icons")
local KEYMAPS = require("tukivim.c.keymaps")

return {
  {
    "nvim-neotest/neotest",
    keys = KEYMAPS.keys("neotest"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-vim-test",
      "stevearc/overseer.nvim",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-vim-test") {
            ignore_file_types = { "python", "vim", "lua" },
          },
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            if UTILS.has("trouble.nvim") then
              vim.cmd("Trouble quickfix")
            else
              vim.cmd("copen")
            end
          end,
        },
        -- overseer.nvim
        consumers = {
          overseer = require("neotest.consumers.overseer"),
        },
        overseer = {
          enabled = true,
          force_default = true,
        },
      }
    end,
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup(opts)
      KEYMAPS.load("neotest")
    end,
  },
  {
    "stevearc/overseer.nvim",
    keys = KEYMAPS.keys("overseer"),
    config = function()
      require("overseer").setup()
      KEYMAPS.load("overseer")
    end,
  },
}
