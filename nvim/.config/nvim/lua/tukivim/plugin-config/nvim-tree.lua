local icons = vim.tukivim.res.icons
vim.g.nvim_tree_icons = {
    default = icons.objects.file,
    symlink = icons.folder.symlink,
    git = {
        unstaged = icons.git.unstaged,
        staged = icons.git.staged,
        unmerged = icons.git.unmerged,
        renamed = icons.git.renamed,
        deleted = icons.git.deleted_a,
        untracked = icons.git.untracked,
        ignored = icons.git.ignored,
    },
    folder = {
        default = icons.folder.default,
        open = icons.folder.open,
        empty = icons.folder.empty,
        empty_open = icons.folder.empty_open,
        symlink = icons.folder.symlink,
    },
}

local tree = vim.tukivim.utils.preq("nvim-tree")
local tree_cb = vim.tukivim.utils.preq("nvim-tree.config").nvim_tree_callback

tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    -- auto_close = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    update_to_buf_dir = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = icons.diagnostic.hint,
            info = icons.diagnostic.info,
            warning = icons.diagnostic.warning,
            error = icons.diagnostic.error,
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 35,
        height = 30,
        hide_root_folder = false,
        side = "left",
        auto_resize = true,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
        number = false,
        relativenumber = false,
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    quit_on_open = 0,
    git_hl = 1,
    disable_window_picker = 0,
    root_folder_modifier = ":t",
    show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
        tree_width = 30,
    },
}