local M = {}

local KEYS_FT = {
  ["cpp"]        = {},
  ["html"]       = {},
  ["java"]       = {},
  ["json"]       = {},
  ["lua"]        = {},
  ["python"]     = {},
  ["rust"]       = {},
  ["typescript"] = {}
}


---Get keys defined at `keys` module OR keys itself
---@param keymaps string|LazyKeys[]
---@return LazyKeys[]
local get_keys = function(keymaps)
  local ret = type(keymaps) == "string" and require("tukivim.c.keymaps.keys")[keymaps] or keymaps
  ---@cast ret LazyKeys[]
  return ret
end


---Set leader key for vim
---@param leader string
M.set_leader = function(leader)
  leader = type(leader) == "string" and leader or " "
  vim.g.mapleader = leader
end


---Load keys by filetype defined at 'tukivim.c.keymaps.filetype'
---@param ft any
---@param bufnr any
M.load_ft = function(ft, bufnr)
  M.load(KEYS_FT[ft], bufnr)
end


---Add key mappings to loading per filetype
---@param ft string
---@param keys string|LazyKeys[]
M.append_ft = function(ft, keys)
  keys = get_keys(keys)
  KEYS_FT[ft] = vim.tbl_deep_extend("force", keys, KEYS_FT[ft])
end


---Load keymaps
---@param keymaps string|LazyKeys[] keymap's module name from `tukivim.c.keymaps.keys` or table of keymaps as LazyKeys
---@param bufnr? number|boolean [opt]
M.load = function(keymaps, bufnr)
  keymaps = type(keymaps) == "string" and require("tukivim.c.keymaps.keys")[keymaps] or keymaps

  ---@cast keymaps LazyKeys[]
  for _, keymap in ipairs(keymaps) do
    M.map(M.parse(keymap), bufnr)
  end
end


---@param keymap LazyKeys
M.parse = function(keymap)
  local ret = vim.deepcopy(keymap)
  ret.mode = ret.mode or "n"
  if ret.mode then
    local mode = ret.mode
    if type(mode) == "table" then
      ---@cast mode string[]
      table.sort(mode)
      mode = table.concat(mode, ", ")
    end
  end
  return ret
end


M.opts = function(keys)
  local opts = {}
  for k, v in pairs(keys) do
    if type(k) ~= "number" and k ~= "mode" and k ~= "id" then
      opts[k] = v
    end
  end
  return opts
end


---@param kmap LazyKeys
M.map = function(kmap, bufnr)
  local opts = M.opts(kmap)
  if bufnr then opts["bufnr"] = bufnr end

  vim.keymap.set(kmap.mode, kmap[1], kmap[2], M.opts(kmap))
end


---get list of LazyKeys[1] ala lhs
---@param keymaps string|LazyKeys[]
---@return table<string,string>
M.keys = function(keymaps)
  keymaps = type(keymaps) == "string" and require("tukivim.c.keymaps.keys")[keymaps] or keymaps
  local ret = {}
  ---@cast keymaps LazyKeys[]
  for _, kmap in ipairs(keymaps) do
    table.insert(ret, { kmap[1], desc = kmap.desc, mode = kmap.mode })
  end
  return ret
end

---Delete keymappings
---@param keymaps string[]|string
---@param buffer number [opt]
M.del = function(keymaps, buffer)
  keymaps = type(keymaps) == "string" and require("tukivim.c.keymaps.keys")[keymaps] or keymaps
  buffer = buffer or 0
  ---@cast keymaps LazyKeys[]
  for _, kmap in ipairs(keymaps) do
    vim.keymap.del(kmap.mode, kmap[1], { buffer = buffer })
  end
end



M.set_leader()

return M
