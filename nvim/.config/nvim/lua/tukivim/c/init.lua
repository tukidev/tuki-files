---@class TukiVimCore
M = {}

---Personal Development Environments avaliability
M.pde = {
  clangd         = true,
  -- cpp           = true,
  cmake         = true,
  -- csharp        = true,
  docker        = true,
  lua           = true,
  python        = true,
  -- rust          = true,
  -- java          = true,
  yaml          = true,
  -- html          = true,
  json          = true,
  -- typescript    = true,
  markdown      = true,
  -- sql           = true,
  hypr          = true,
  meson         = true,
  ['front-end'] = true,
}

M.extra = {
  obsidian     = true,
  iron         = true,
  ["zen-mode"] = true,
}

---Setup TukiVim configuration
---@param opts? table optional
M.setup = function(opts)
  require("tukivim.c.settings").setup()
  require("tukivim.c.autocmd")
  require("tukivim.c.lazy").setup()
  require("tukivim.c.keymaps").load("default")
end


return M
