if not require("tukivim.c").pde["sql"] then
  return {}
end

local KEYMAPS = require("tukivim.c.keymaps")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "sql" })
    end,
  },

  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      {
        'tpope/vim-dadbod',
        lazy = true,
      },
      {
        'kristijanhusak/vim-dadbod-completion',
        lazy = true,
        ft = { 'sql', 'mysql', 'plsql' },
      },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = KEYMAPS.keys("dadbod-ui"),
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
      KEYMAPS.load("dadbod-ui")
    end
  }
}
