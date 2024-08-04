---Bootstraping `lazy.nvim` plugin manager
---@param lazypath? string
local BOOTSTRAP_LAZY = function(lazypath)
  lazypath = lazypath or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
    vim.notify("Installing `lazy.nvim` close and reopen Neovim...", vim.log.levels.INFO, { render = "minimal" })
  end
  vim.opt.rtp:prepend(lazypath)
end

---convert modules array to lazy.opts.spec format
---@param modules string[]
local to_lazy_spec = function(modules)
  local ret = {}
  for _, m in ipairs(modules) do
    table.insert(ret, { import = m })
  end
  return ret
end

local LAZY_DEFAULT_MODULES = {
  { import = "tukivim.plugins.lsp" },
  { import = "tukivim.plugins.coding" },
  { import = "tukivim.plugins.tools" },
  { import = "tukivim.plugins.test" },
  { import = "tukivim.plugins.editor" },
  { import = "tukivim.plugins.ui" },
  { import = "tukivim.plugins.others" },
  { import = "tukivim.plugins.extra" },
  { import = "tukivim.plugins.colorschemes.catppuccin" },
  { import = "tukivim.pde" },
}


local LAZY_DEFAULTS = {
  spec = LAZY_DEFAULT_MODULES,
  defaults = { lazy = false },
  dev = { patterns = { "tuki", "tukivim" } },
  install = {
    missing = true,
    colorscheme = { "catppuccin" },
  },
  checker = { enabled = true },
  diff = { cmd = "git" },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    size = { width = 0.64, height = 0.8 },
    wrap = true,
    border = "none",
    icons = require("tukivim.c.res.icons").lazy,
  },
}

local M = {}

local IS_LAZY_LOADED = false

---Init `lazy.nvim` plugin manager
---@param lazy_opts? table
---@param lazypath? string
M.init = function(lazy_opts, lazypath)
  BOOTSTRAP_LAZY(lazypath)
  lazy_opts = lazy_opts or LAZY_DEFAULTS
  -- require("lazy").setup(lazy_opts)
  IS_LAZY_LOADED = true
end

---Setup `lazy.nvim` plugin manager
---@param modules? table
M.setup = function(modules)
  if not IS_LAZY_LOADED then M.init() end
  require("lazy").setup(
    vim.tbl_deep_extend(
      "force",
      { spec = modules and to_lazy_spec(modules) or LAZY_DEFAULT_MODULES },
      LAZY_DEFAULTS
    )
  )
  vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy (Manage Plugins)" })
end


return M
