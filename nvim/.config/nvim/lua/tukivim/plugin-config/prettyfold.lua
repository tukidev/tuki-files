vim.tukivim.utils.psetup('pretty-fold', {
    sections = {
        left = {
            function() return string.rep(' ', vim.v.foldlevel*2-3) end,
            '+-', 'content', ' ---- [ ', 'number_of_folded_lines', ' ]'
        },
    },
    fill_char = ' ',    -- variants : ' ' | '•'
    remove_fold_markers = true,
    keep_indentation = false,
    process_comment_signs = 'spaces',      -- 'delete' | 'spaces' | false
    -- comment_signs = {},

    stop_words = {
        '@brief%s*', -- (for C++) Remove '@brief' and all spaces after.
    },

    add_close_pattern = true, -- true, 'last_line' or false
    matchup_patterns = {
        --- [ lua ]
        { '^%s*do$', 'end' }, -- `do ... end` blocks
        { '^%s*if', 'end' },
        { '^%s*for', 'end' },
        { 'function%s*%(', 'end' }, -- 'function(' or 'function ('

        {  '{', '}' },
        { '%(', ')' }, -- % to escape lua pattern char
        { '%[', ']' }, -- % to escape lua pattern char
    },

    ft_ignore = { 'neorg' },
})

vim.cmd([[ highlight Folded guifg=#988BA2 guibg=#1E1E2E ]])


require('pretty-fold.preview').setup({
    default_keybindings = true, -- Set to false to disable default keybindings
    border = 'single'           -- 'none' | "single" | "double" | "rounded" | "solid" | 'shadow' | table
})
