local defaults = require("tukivim.com.keymaps.loader.defaults")

local Loader = {}

function Loader.setup(init)
    local self = {}

    self.keymaps = {}
    self.bufnr = nil        -- A buffer nr to set keymaps

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
        local default = self.keymaps
        for mode, mappings in pairs(keymaps) do
            local translated_mode = defaults.mode_adapters[mode] or mode
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


    ---Set keymaps using `which-key` plugin
    -- WARN: use after `which-key` plugin is loaded
    -- @param keymaps table of keymaps
    -- @param opts table of options
    function self.set_keymaps_wk(keymaps, opts)
        vim.tukivim.plugins["which-key"].register(keymaps, opts)
    end


    -- Get final params to set keymap
    local function getparams(mode, key, val)
        local opt = defaults.mode_opts[mode] or defaults.opts
        if type(val) == "table" then
            opt = val[2]
            val = val[1]
        end
        return key, val, opt
    end


    -- Set key mappings individually
    -- @param mode The keymap mode, can be one of the keys of mode_adapters
    -- @param key The key of keymap
    -- @param val Can be form as a mapping or tuple of mapping and user defined opt
    function self.set_keymaps(mode, key, val)
        local opt = nil
        key, val, opt = getparams(mode, key, val)

        if val then
            vim.api.nvim_set_keymap(mode, key, val, opt)
        else
            pcall(vim.api.nvim_del_keymap, mode, key)
        end
    end


    --- Set key mappings individually for bufnr
    -- @param mode The keymap mode, can be one of the keys of mode_adapters
    -- @param key The key of keymap
    -- @param val Can be form as a mapping or tuple of mapping and user defined opt
    function self.set_buf_keymaps(mode, key, val, bufnr)
        local opt = nil
        key, val, opt = getparams(mode, key, val)

        if val then
            vim.api.nvim_buf_set_keymap(bufnr, mode, key, val, opt)
        else
            pcall(vim.api.nvim_buf_del_keymap, bufnr, mode, key)
        end
    end


    --- Load key mappings for a given mode MANUALLY
    -- @param mode The keymap mode, can be one of the keys of mode_adapters
    -- @param keymaps The list of key mappings
    -- @param bufnr buffer where to load keymaps
    function self.load_mode_manual(mode, keymaps, bufnr)
        local f_setkeymap = bufnr and self.set_buf_keymaps or self.set_keymaps  -- chosing the correct function
        mode = defaults.mode_adapters[mode] or mode
        for map, cmd in pairs(keymaps) do
            f_setkeymap(mode, map, cmd, bufnr)
        end
    end


    --- Load key mappings for a given mode
    -- @param mode The keymap mode, can be one of the keys of mode_adapters
    -- @param keymaps The list of key mappings
    -- @param bufnr buffer where to load keymaps
    -- @param wk_flag flag of using `which-key` plugin
    function self.load_mode(mode, keymaps, bufnr, wk_flag)
        if wk_flag then
            self.set_keymaps_wk(keymaps,
                defaults.opts_wk(defaults.prefix, bufnr)[mode])
        else
            self.load_mode_manual(mode, keymaps, bufnr)
        end

    end


    --- Load key mappings for all provided modes
    -- @param keymaps A list of key mappings for each mode
    -- @param bufnr buffer where to load keymaps
    -- @param wk_flag flag of using `which-key` plugin
    function self.load_keymaps(keymaps, bufnr, wk_flag)
        self.keymaps = keymaps or {}
        self.load(bufnr, wk_flag)
    end


    --- Load key mappings for all provided modes from saved keymaps
    -- @param bufnr buffer where to load keymaps
    -- @param wk_flag flag of using `which-key` plugin
    function self.load(bufnr, wk_flag)
        self.bufnr = bufnr
        for mode, mapping in pairs(self.keymaps) do
            self.load_mode(mode, mapping, bufnr, wk_flag)
        end
    end


    self.setup(init)
    return self
end


return Loader
