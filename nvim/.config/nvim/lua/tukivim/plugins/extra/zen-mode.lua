if not require("tukivim.c").extra["zen-mode"] then
  return {}
end

local KEYMAPS = require("tukivim.c.keymaps")

return {
  {
    "folke/zen-mode.nvim",
    keys = KEYMAPS.keys("zen-mode"),
    cmd = { "ZenMode" },
    dependencies = {
      "folke/twilight.nvim",
      lazy = true,
      cmd = "Twilight",
      opts = { context = 15 }
    },
    opts = {
      window = {
        backdrop = 1,     -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 140,      -- width of the Zen window
        height = 1,       -- height of the Zen window
        options = {
          number = false, -- disable number column
          winbar = "",
          -- cursorline = false,     -- disable cursorline
          -- signcolumn = "no",      -- disable signcolumn
          -- relativenumber = false, -- disable relative numbers
          -- cursorcolumn = false,   -- disable cursor column
          -- foldcolumn = "0",       -- disable fold column
          -- list = false,           -- disable whitespace characters
        },
      },
      plugins = {
        options = {
          enabled = true,
          laststatus = 0, -- turn off the statusline in zen mode
          winbar = "",
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = true },     -- disables the tmux statusline
        kitty = { enabled = false, font = "+4" },
      },
    },
    config = function(_, opts)
      require("zen-mode").setup(opts)
      KEYMAPS.load("zen-mode")
    end
  },
}
