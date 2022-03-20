local R = {}

-- make structure of PATHes
R.path = {
    n = "tukivim",
    p = nil,
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


R.icons = {
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    },
    diagnostic = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    },
    git = {
        github = "",
        branch_a = "",
        branch_b = "",
        unstaged = "",
        staged = "",
        unmerged = "",
        renamed = "",
        deleted_a = "",
        deleted_b = "",
        added_a = "",
        added_b = "",
        modified = "",
        untracked = "",
        ignored = "◌",
    },
    indicators = {
        check = "",
        check_circle_a = "",
        check_circle_b = "",
        check_box_a = "",
        check_box_b = "",

        times = "",
        times_circle_a = "",
        times_circle_b = "",
        times_box_a = "",
        times_box_b = "",

        question = "",
        question_circle_a = "",
        question_circle_b = "",

        info = "",
        info_circle_a = "",
        info_circle_b = "𥉉",
        info_circle_c = "",

        plus = "",
        plus_circle_a = "",
        plus_box_a = "",
        plus_box_b = "",

        minus = "",
        minus_circle_a = "",
        minus_circle_b = "",
        minus_circle_c = "",
        minus_box_a = "",
        minus_box_b = "",

    },
    objects = {
        line_v_left = "▎",
        triangle_m_right = "",
        triangle_m_down = "",
        triangle_m_up = "",
        triangle_l_right = "",
        triangle_l_left = "",
        angle_l_right = "",
        angle_l_left = "",
        file = "",
        linux = "",
        rocket = "",
         -- = "",
    },
}

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
