if not require("tukivim.c").pde["hypr"] then
  return {}
end

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start {
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    }
  end
})

-- Hyprlang TreeSitter
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "hyprlang" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "hyprls" })
      end,
    },
    opts = {
      servers = {
        ["hyprls"] = {},
      },
    },
  },
}
