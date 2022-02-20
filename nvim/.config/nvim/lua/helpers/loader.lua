local loader = {}

-- main function to call
-- load plugins and then require threir configuretions
-- @params plugins : table (with format { plugin, configuration })
function loader.load(plugins)
    plugins = plugins or {}
    for plugin, configuration in pairs(plugins) do
        require(plugin)
    end
end

function loader.checkPackerEnable()
    local naked = #vim.api.nvim_list_uis() == 0
end

return loader
