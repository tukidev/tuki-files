local R = {}

R.path = {
    n = "tukivim",
    p = nil,

    com = {
        n = "com",
        p = nil,
        res = {
            n = "res",
            p = nil,
            icons = { n = "icons", },
            path = { n = "path", },
        },
        src = {
            n = "source",
            p = nil,
            utils = { n = "utils", p = nil, }
        },
        settings = {
            n = "settings",
            p = nil,
            loader = { n = "loader", p = nil, }
        },
        keymaps = {
            n = "keymaps",
            p = nil,
            loader = { n = "loader", p = nil, }
        },
        commands = {
            n = "commands",
            p = nil,
        },
    },

    config = {
        n = "plugin-config",
        p = nil,
    },
}

--#region set path fields
R.path.p = R.path.n

R.path.com.p = R.path.p .. '.' .. R.path.com.n

R.path.com.res.p = R.path.com.p .. '.' .. R.path.com.res.n
R.path.com.res.icons.p = R.path.com.res.p .. '.' .. R.path.com.res.icons.n
R.path.com.res.path.p = R.path.com.res.p .. '.' .. R.path.com.res.path.n

R.path.com.commands.p = R.path.com.p .. '.' .. R.path.com.commands.n
R.path.com.src.p = R.path.com.p .. '.' .. R.path.com.src.n
R.path.com.src.utils.p = R.path.com.src.p .. '.' .. R.path.com.src.utils.n

R.path.com.settings.p = R.path.com.p .. '.' .. R.path.com.settings.n
R.path.com.settings.loader.p = R.path.com.settings.p .. '.' .. R.path.com.settings.loader.n

R.path.com.keymaps.p = R.path.com.p .. '.' .. R.path.com.keymaps.n
R.path.com.keymaps.loader.p = R.path.com.keymaps.p .. '.' .. R.path.com.keymaps.loader.n

R.path.config.p = R.path.p .. '.' .. R.path.config.n
--#endregion


R.icons = require(R.path.com.res.icons.p)

--[[
---fill PATHes fields
---uses BFS to path a tree
---@param tree table
local function gen_path_tree(tree, source)
    if tree == nil then return end          -- return if list is empty

    tree['p'] = source .. '.' .. tree['n']  -- gen path for current folder

    for i=2,tree.getn do
        gen_path_tree(tree[i], tree['p'])   -- go to next folder (BFS)
    end
end
gen_path_tree(R.path, "tukivim")
]]--

return R
