if not require("tukivim.c").extra["iron"] then
  return {}
end

local KEYS = require("tukivim.c.keymaps")

return {
  {
    "Vigemus/iron.nvim",
    keys = KEYS.keys("iron"),
    -- ft = { "python" },
    opts = {
      config = {
        scratch_repl = true, -- Whether a repl should be discarded or not
        repl_definition = {  -- Your repl definitions come here
          sh = { command = { "zsh" } },
        },
        repl_open_cmd = "vertical botright 50% split"
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      -- keymaps = {
      --   send_motion = "<leader>ic",
      --   visual_send = "<leader>ic",
      --   send_file = "<leader>if",
      --   send_line = "<leader>il",
      --   send_paragraph = "<leader>ip",
      --   send_until_cursor = "<leader>iu",
      --   send_mark = "<leader>im",
      --   mark_motion = "<leader>ic",
      --   mark_visual = "<leader>ic",
      --   remove_mark = "<leader>id",
      --   cr = "<leader>i<cr>",
      --   interrupt = "<leader>i<space>",
      --   exit = "<leader>iq",
      --   clear = "<leader>il",
      -- },

      highlight = { italic = true },
      ignore_blank_lines = true,
    },
    config = function(_, opts)
      local iron = require("iron.core")
      iron.setup(opts)
      KEYS.load("iron")
    end
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.spec, {
        { "<leader>i", group = "[I]ron", icon = { icon = "", color = "orange" } },
      })
    end,
  }
}
