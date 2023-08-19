local D = require("tukivim.com.keymaps.loader.defaults")

local function get_params(mode, lhs, rhs, buf)
	local opts = buf and D.opts_of(buf) or { remap = false, silent = true }

	if type(rhs) == "table" then
		if type(rhs[2]) == "table" then
      opts = rhs[2]
		else
			opts["desc"] = rhs[2]
		end
		rhs = rhs[1]
	end

	return D.mode_adapters[mode], lhs, rhs, opts
end

local L = {}

---Set keymap
---@param mode string The keymap mode, can be one of the keys of mode_adapters
---@param lhs string The key of keymap
---@param rhs string Can be form as a mapping or tuple of mapping and user defined opt
---@param buf integer Buffer where map that keymap
function L.set_keymap(mode, lhs, rhs, buf)
	if rhs then
		vim.keymap.set(get_params(mode, lhs, rhs, buf))
	else
		vim.keymap.del(mode, lhs, { buffer = buf })
	end
end

--- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
-- @param bufnr buffer where to load keymaps
function L.load_mode(mode, maps, buf)
	-- local f_setkeymap = buf and
	-- Loader.set_buf_keymaps or self.set_keymaps
	-- mode = defaults.mode_adapters[mode] or mode

	for lhs, rhs in pairs(maps) do
		L.set_keymap(mode, lhs, rhs, buf)
		-- f_setkeymap(mode, lhs, rhs, buf)
	end
end

--- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
-- @param bufnr buffer where to load keymaps
function L.load_keymaps(keymaps, bufnr)
	keymaps = keymaps or {}
	for mode, mapping in pairs(keymaps) do
		L.load_mode(mode, mapping, bufnr)
	end
end

--- Load key mappings for a given mode by using `which-key` plugin
--- WARN: need `which-key` plugin
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
-- @param bufnr buffer where to load keymaps
function L.load_mode_wk(mode, maps, prefix, bufnr)
	require("which-key").register(maps, D.opts_wk(prefix, bufnr)[mode])
end

function L.load_keymaps_wk(keymaps, prefix, bufnr)
	keymaps = keymaps or {}
	prefix = prefix or D.prefix
	for mode, maps in pairs(keymaps) do
		L.load_mode_wk(mode, maps, prefix, bufnr)
	end
end

return L
