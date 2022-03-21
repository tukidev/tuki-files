local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
    insert_mode = generic_opts_any,
    normal_mode = generic_opts_any,
    visual_mode = generic_opts_any,
    visual_block_mode = generic_opts_any,
    command_mode = generic_opts_any,
    term_mode = { silent = true },
}

local mode_adapters = {
    insert_mode = "i",
    normal_mode = "n",
    term_mode = "t",
    visual_mode = "v",
    visual_block_mode = "x",
    command_mode = "c",
}


function Loader(init)
    local self = {}

    self.keymaps = {}


    function self.setup(keymaps)
        self.keymaps = keymaps or {}
        return self
    end


    -- Append key mappings to lunarvim's defaults for a given mode
    -- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
    function self.append(keymaps)
        for mode, mappings in pairs(keymaps) do
            for map, cmd in pairs(mappings) do
                self.keymaps[mode][map] = cmd
            end
        end
    end

    -- Unsets all keybindings defined in keymaps
    -- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
    function self.clear(keymaps)
        local default = self.get_defaults()
        for mode, mappings in pairs(keymaps) do
            local translated_mode = mode_adapters[mode] or mode
            for key, _ in pairs(mappings) do
                -- some plugins may override default bindings that the user hasn't manually overriden
                if default[mode][key] ~= nil
                    or (default[translated_mode] ~= nil
                    and default[translated_mode][key] ~= nil) then
                    pcall(vim.api.nvim_del_keymap, translated_mode, key)
                end
            end
        end
    end

    -- Set key mappings individually
    -- @param mode The keymap mode, can be one of the keys of mode_adapters
    -- @param key The key of keymap
    -- @param val Can be form as a mapping or tuple of mapping and user defined opt
    function self.set_keymaps(mode, key, val)
        local opt = generic_opts[mode] or generic_opts_any
        if type(val) == "table" then
            opt = val[2]
            val = val[1]
        end
        if val then
            vim.api.nvim_set_keymap(mode, key, val, opt)
        else
            pcall(vim.api.nvim_del_keymap, mode, key)
        end
    end

    -- Load key mappings for a given mode
    -- @param mode The keymap mode, can be one of the keys of mode_adapters
    -- @param keymaps The list of key mappings
    function self.load_mode(mode, keymaps)
        mode = mode_adapters[mode] or mode
        for map, cmd in pairs(keymaps) do
            self.set_keymaps(mode, map, cmd)
        end
    end


    -- Load key mappings for all provided modes
    -- @param keymaps A list of key mappings for each mode
    function self.load_keymaps(keymaps)
        self.keymaps = keymaps or {}
        self.load()
    end


    -- Load key mappings for all provided modes from saved keymaps
    function self.load()
        for mode, mapping in pairs(self.keymaps) do
            self.load_mode(mode, mapping)
        end
    end


    self.setup(init)
    return self
end


return Loader()
