if not require("tukivim.c").pde["cmake"] then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "cmake" })
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.cmake_lint,
      })
    end,
  },
  {
    "mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "cmakelang" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        ["neocmake"] = {},
      },
    },
  },
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp" },
    event = "BufRead",
    opts = {},
  },
}
