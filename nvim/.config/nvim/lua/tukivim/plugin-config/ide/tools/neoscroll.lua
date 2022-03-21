vim.tukivim.register("neoscroll", {
    hide_cursor = true,                 -- Hide cursor while scrolling
    stop_eof = true,                    -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false,        -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = true,          -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true,        -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,              -- Default easing function
    pre_hook = nil,                     -- Function to run before the scrolling animation starts
    post_hook = nil,                    -- Function to run after the scrolling animation ends
    performance_mode = false,           -- Disable "Performance Mode" on all buffers.
})

-- local mappings_defaults = {
--     ['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}},
--     ['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}},
--     ['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}},
--     ['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450'}},
--     ['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}},
--     ['<C-e>'] = {'scroll', { '0.10', 'false', '100'}},
--     ['zt']    = {'zt', {'250'}},
--     ['zz']    = {'zz', {'250'}},
--     ['zb']    = {'zb', {'250'}},
-- }

-- require('neoscroll.config').set_mappings(mappings)
