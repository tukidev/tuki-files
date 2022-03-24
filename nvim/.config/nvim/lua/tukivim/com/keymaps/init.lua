-- TODO: import `almost ALL` keymaps to `which-key` plugin

local leader_default = ' '

local keys = {
    whichkey = require("tukivim.com.keymaps.wk_maps"),
    defaults = require("tukivim.com.keymaps.defaults"),
    lsp = require("tukivim.com.keymaps.lsp_maps"),
    -- explorer = require("tukivim.com.keymaps.explorer")
}

local KeymapsLoader = {}


function KeymapsLoader.new()
    local self = {}
    self.leader = leader_default


    function self.load_module(module, buff, wk_flag)
        if not keys[module] then return end
        self[module] = keys[module]
        self[module].load(buff, wk_flag)
    end


    function self.load_defaults()
        self.load_module("defaults")
        self.load_module("whichkey", nil, true)
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

return KeymapsLoader
