local Utils = {}

function Utils.path_to_list(path, list)
    list = list or {}
    local res = {}
    for _, item in ipairs(list) do
        table.insert(res, path .. '.' .. item)
    end
    return res
end


function Utils.print_list_of_strings(list)
    print("\nList = [\n")
    for _, it in ipairs(list) do
        print(it .. '\n')
    end
    print(']\n')
end


function Utils.require_checked(plugin_name, config)
    local ok, plugin = pcall(require, plugin_name)
    if not ok then                                  -- TODO: exception handler | notify
        return
    end
    if config then plugin.setup(config) end
    return plugin
end


function Utils.req_list(plugins)
    plugins = plugins or {}
    for _, it in ipairs(plugins) do
        pcall(require, it)
    end
end

return Utils
