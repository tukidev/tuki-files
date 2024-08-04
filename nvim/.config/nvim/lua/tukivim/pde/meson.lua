if not require("tukivim.c").pde["meson"] then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "meson" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        ["mesonlsp"] = {}
      }
    },
  }

}
