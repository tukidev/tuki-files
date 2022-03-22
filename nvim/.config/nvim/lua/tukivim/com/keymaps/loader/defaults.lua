local M = {}

---Generate default options table for which-key plugin
---@param mode string : `n` (default) | `i` | `c` | `v` | `x` | `t`
---@param key string : keymap prefix
---@return table
function M.gen_opts_wk(mode, key)
    mode = mode or 'n'
    key = key or "<leader>"
    return {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    }
end


---Default options for `insert` and `normal` modes
M.opts_wk = {
    insert_mode = {
        mode = "i",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    },
    normal_mode = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    },
}


M.opts = { noremap = true, silent = true }
M.mode_opts = {
    insert_mode = M.opts,
    normal_mode = M.opts,
    visual_mode = M.opts,
    command_mode = M.opts,
    visual_block_mode = M.opts,
    term_mode = { silent = true },
}

M.mode_adapters = {
    insert_mode = "i",
    normal_mode = "n",
    term_mode = "t",
    visual_mode = "v",
    visual_block_mode = "x",
    command_mode = "c",
}

return M
