-- TODO: import `almost ALL` keymaps to `which-key` plugin

local leader_default = ' '

function KeymapsLoader()
    local self = {}
    self.leader = leader_default
    self.keymaps = {}
    self.keymaps.defaults = require("tukivim.com.keymaps.defaults")
    self.keymaps.lsp      = require("tukivim.com.keymaps.lsp_maps")

    -- self.explorer = require("tukivim.master.defaults.keymappings.explorer")

    function self.load_module(module, buff, wk_flag)
        self.keymaps[module].load(buff, wk_flag)
    end

    local function load_modules()
        self.keymaps.defaults.load()
        -- self.keymaps.wk.load(nil, true)
    end

    --#region public methods

    function self.load()
        vim.g.mapleader = self.leader
        load_modules()
    end


    function self.set_leader(keymap)
        self.leader = keymap or leader_default
    end
    --#endregion


    self.set_leader()

    return self
end

return KeymapsLoader()
