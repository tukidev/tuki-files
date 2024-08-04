if not require("tukivim.c").pde["markdown"] then
  return {}
end

return {
  -- add yaml specific modules to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["marksman"] = {}
      },
    },
  },
}
