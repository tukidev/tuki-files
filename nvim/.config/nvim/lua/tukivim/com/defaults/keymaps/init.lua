local leader_default = ' '


function K()
    local self = {}

    self.leader = nil

    self.defaults = require("tukivim.com.defaults.keymaps.defaults")
    -- self.lsp = require("tukivim.master.defaults.keymappings.lsp")
    -- self.explorer = require("tukivim.master.defaults.keymappings.explorer")
    -- self.wk = require("tukivim.master.defaults.keymappings.wk")


    local function load_modules()
        self.defaults.load()
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

return K()
