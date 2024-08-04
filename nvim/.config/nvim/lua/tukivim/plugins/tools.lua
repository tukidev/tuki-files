local UTILS = require("tukivim.c.utils")
local ICONS = require("tukivim.c.res.icons")
local KEYMAPS = require("tukivim.c.keymaps")

return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = { "telescope-fzf-native", "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = KEYMAPS.keys("telescope"),
    opts = function()
      local action = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix    = ICONS.telescope.prompt_prefix,
          selection_caret  = ICONS.telescope.selection_caret,
          path_display     = { "smart" },
          sorting_strategy = "ascending",
          layout_strategy  = "horizontal",
          layout_config    = {
            horizontal     = {
              prompt_position = "top",
              preview_width   = 0.55,
              results_width   = 0.8,
            },
            vertical       = { mirror = false },
            width          = 0.75,
            height         = 0.70,
            preview_cutoff = 120,
          },
          ---[[
          mappings         = {
            i = {
              ["<C-j>"]   = action.move_selection_next,
              ["<C-k>"]   = action.move_selection_previous,

              ["<CR>"]    = action.select_default,
              ["<C-s>"]   = action.select_horizontal,
              ["<C-v>"]   = action.select_vertical,
              ["<C-t>"]   = action.select_tab,
              ["<C-p>"]   = require("telescope.actions.layout").toggle_preview,

              ["<Tab>"]   = action.toggle_selection + action.move_selection_worse,
              ["<S-Tab>"] = action.toggle_selection + action.move_selection_better,

              ["<C-l>"]   = action.complete_tag,
              ["<C-_>"]   = action.which_key, -- keys from pressing <C-/>
            },

            n = {
              ["<esc>"] = action.close,
              ["<CR>"]  = action.select_default,
              ["<C-x>"] = action.select_horizontal,
              ["<C-v>"] = action.select_vertical,
              ["<C-t>"] = action.select_tab,
              ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
              ["j"]     = action.move_selection_next,
              ["k"]     = action.move_selection_previous,
              ["H"]     = action.move_to_top,
              ["M"]     = action.move_to_middle,
              ["L"]     = action.move_to_bottom,
              ["gg"]    = action.move_to_top,
              ["G"]     = action.move_to_bottom,
              ["?"]     = action.which_key,
            },
          },
          --]]
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("notify")
      require("telescope").load_extension("projects")

      KEYMAPS.load("telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    name = "telescope-fzf-native",
    lazy = true,
    build = "make",
    -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release "
    --     .. "&& cmake --build build --config Release && cmake --install build --prefix build",
    config = function()
      require("telescope").setup({
        extensions = {
          ["fzf"] = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case", -- "ignore_case" | "respect_case"
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "telescope.nvim" },
    keys = KEYMAPS.keys("telescope-dap"),
    config = function()
      require("telescope").load_extension("dap")
      KEYMAPS.load("telescope-dap")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "telescope.nvim" },
    keys = KEYMAPS.keys("harpoon"),
    config = function()
      require("harpoon").setup()
      KEYMAPS.load("harpoon")
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {},
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        keys = {},
        opts = {
          enabled                     = true,     -- enable this plugin (the default)
          enabled_commands            = true,     -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true,     -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed    = true,     -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason            = true,     -- show stop reason when stopped for exceptions
          commented                   = false,    -- prefix virtual text with comment string
          virt_text_pos               = "inline", -- position of virtual text, see `:h nvim_buf_set_extmark()`

          -- experimental features:
          all_frames                  = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          virt_lines                  = false, -- show virtual lines instead of virtual text (will flicker!)
          virt_text_win_col           = nil,   -- position the virtual text at a fixed window column (starting from the first text column) ,
        },
      },
      {
        "rcarriga/nvim-dap-ui",
        commit = "f2206de65ea39093e3f13992507fc985c17aa763", -- WARN: up-to-date is broken for `Java` language
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = KEYMAPS.keys("dap-ui"),
        opts = {
          layouts = {
            {
              elements = { { id = "stacks", size = 0.5 }, { id = "watches", size = 0.5 } },
              position = "left",
              size = 40,
            },
            {
              elements = { { id = "repl", size = 0.5 }, { id = "console", size = 0.5 } },
              position = "bottom",
              size = 0.3,
            },
          },
        },
        config = function(_, opts)
          require("dapui").setup(opts)
          KEYMAPS.load("dap-ui")
        end,
      },
      {
        "mfussenegger/nvim-dap-python",
        config = function() require("dap-python").setup("/opt/miniconda3/bin/python") end,
      },
    },
    keys = { "<leader>dd", "<leader>dl", "<F1>", "<F5>" },
    config = function()
      local dap_signs = {
        ["Breakpoint"]          = "",
        ["BreakpointCondition"] = "",
        ["LogPoint"]            = "",
      }

      local dap_sign_name = ""
      for name, sign in pairs(dap_signs) do
        dap_sign_name = "Dap" .. name
        vim.fn.sign_define(dap_sign_name, {
          text   = sign,
          texthl = dap_sign_name,
          linehl = "",
          numhl  = "",
        })
      end

      KEYMAPS.load("dap")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function() require("project_nvim").setup() end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    keys = KEYMAPS.keys("persistence"),
    config = function(_, opts)
      require("persistence").setup(opts)
      KEYMAPS.load("persistence")
    end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "ToggleTermToggleAll" },
    keys = KEYMAPS.keys("toggleterm"),
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 18
        elseif term.direction == "vertical" then
          return vim.o.columns(0.4)
        end
      end,

      open_mapping = [[<C-t>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      KEYMAPS.load("toggleterm")
    end
  }
}
