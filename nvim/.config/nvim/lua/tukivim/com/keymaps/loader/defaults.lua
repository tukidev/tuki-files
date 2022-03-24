local M = {}
M.prefix = '<leader>'


---Generate default options table for which-key plugin
---@param mode string : `n` (default) | `i` | `c` | `v` | `x` | `t`
---@param key string : keymap prefix
---@return table
function M.gen_opts_wk(mode, key, buf)
    mode = mode or 'n'
    key = key or M.prefix
    return {
        mode = mode,
        prefix = key,
        buffer = buf,
        silent = true,
        noremap = true,
        nowait = true,
    }
end


---Default options for `insert` and `normal` modes
M.opts_wk = function (prefix, buf)
    prefix = prefix or M.prefix
    return {
        insert_mode = {
            mode = "i",
            prefix = prefix,
            buffer = buf,
            silent = true, noremap = true, nowait = true,   -- standart opts
        },
        normal_mode = {
            mode = "n",
            prefix = prefix,
            buffer = buf,
            silent = true, noremap = true, nowait = true,
        },
        visual_mode = {
            mode = "v",
            prefix = prefix,
            buffer = buf,
            silent = true, noremap = true, nowait = true,
        },
    }
end


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
