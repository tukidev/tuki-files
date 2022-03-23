local R = {}

-- make structure of PATHes
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
        ide = {
            n = "ide",
            p = nil,
            cmp = {
                n = "completion",
                p = nil
            },
            diagnostic = {
                n = "diagnostic",
                p = nil,
                lsp = {
                    n = "lsp",
                    p = nil
                },
                null_ls = {
                    n = "null_ls",
                    p = nil
                },
            },
            tools = {
                n = "tools",
                p = nil
            },
        },
        ui = {
            n = "ui",
            p = nil,
            colorschemes = {
                n = "colorschemes",
                p = nil
            },
            view = {
                n = "view",
                p = nil
            },
        },
        opt = {
            n = "opt",
            p = nil,
        }
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
R.path.config.opt.p = R.path.config.p .. '.' .. R.path.config.opt.n

R.path.config.ide.p = R.path.config.p .. '.' .. R.path.config.ide.n
R.path.config.ide.cmp.p = R.path.config.ide.p .. '.' .. R.path.config.ide.cmp.n
R.path.config.ide.tools.p = R.path.config.ide.p .. '.' .. R.path.config.ide.tools.n
R.path.config.ide.diagnostic.p = R.path.config.ide.p .. '.' .. R.path.config.ide.diagnostic.n
R.path.config.ide.diagnostic.lsp.p = R.path.config.ide.diagnostic.p .. '.' .. R.path.config.ide.diagnostic.lsp.n
R.path.config.ide.diagnostic.null_ls.p = R.path.config.ide.diagnostic.p .. '.' .. R.path.config.ide.diagnostic.null_ls.n

R.path.config.ui.p = R.path.config.p .. '.' .. R.path.config.ui.n
R.path.config.ui.colorschemes.p = R.path.config.ui.p .. '.' .. R.path.config.ui.colorschemes.n
R.path.config.ui.view.p = R.path.config.ui.p .. '.' .. R.path.config.ui.view.n
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
