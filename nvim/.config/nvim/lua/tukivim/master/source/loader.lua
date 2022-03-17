---require list of plugins

local Loader = {}

function Loader:new(plugins)
    self = {}
    self.plugins = plugins or {}
    self.__index = self

    function self.set_plugins(plugin_list)  -- setter
        self.plugins = plugin_list or {}
    end


    function self.add(plugin_list)
        for _, plugin in ipairs(plugin_list) do
            table.insert(self.plugins, plugin)
        end
    end


    function self.load()
        for _, plugin in ipairs(self.plugins) do
            pcall(require, plugin)
        end
    end

    return self
end

-- function Loader:set_plugins(plugin_list)  -- setter
--     self.plugins = plugin_list or {}
-- end
--
--
-- function Loader:add(plugin_list)
--     for _, plugin in ipairs(plugin_list) do
--         table.insert(self.plugins, plugin)
--     end
-- end
--
--
-- function Loader:load()
--     for _, plugin in ipairs(self.plugins) do
--         pcall(require, plugin)
--     end
-- end

-- return function (plugins)
--     return Loader.new(plugins)
-- end

return Loader


-- local l = Loader({
--     "loadre",
--     "rere",
--     "qqq",
-- })
--
--
-- l.load()

