local L = require("tukivim.com.keymaps.loader")
local U = require("tukivim.com.source.utils")
local leader_default = " "

local keys = {
	whichkey = "tukivim.com.keymaps.wk",
	defaults = "tukivim.com.keymaps.defaults",
	lsp = "tukivim.com.keymaps.lsp",
	lsp_wk = "tukivim.com.keymaps.lsp_wk",

	telekasten = "tukivim.com.keymaps.telekasten",
	telekasten_wk = "tukivim.com.keymaps.telekasten_wk",
}

---Save and loads Tukivim's keymaps
---Avaible keymaps modules:
--- * defaults
--- * whichkey
--- * lsp
function KeymapsLoader()
	local self = {}
	self.leader = leader_default

	function self.load_module(module, buff)
		if not keys[module] then
			return -- TODO: notify!!!
		end

		local keymaps = require(keys[module])

		L.load_keymaps(keymaps, buff)
	end

	function self.load_module_wk(module, prefix, buff)
		if not keys[module] then
			return -- TODO: notify!!!
		end

		local keymaps = require(keys[module])
		L.load_keymaps_wk(keymaps, prefix, buff)
		-- code
	end

	--- Loads `defaults` and `whichkey` modules
	function self.load_defaults()
		self.load_module("defaults")
		self.load_module_wk("whichkey", self.leader)
	end

	function self.load()
		vim.g.mapleader = self.leader
		self.load_defaults()
	end

	function self.set_leader(keymap)
		self.leader = keymap or leader_default
	end

	self.set_leader()

	return self
end

return KeymapsLoader()
