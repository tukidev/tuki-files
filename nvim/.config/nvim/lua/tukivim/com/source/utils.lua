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


function Utils.req_list(plugins)
    plugins = plugins or {}
    for _, it in ipairs(plugins) do
        pcall(require, it)
    end
end

return Utils
