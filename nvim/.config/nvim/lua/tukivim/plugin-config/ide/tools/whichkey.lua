local conf = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = vim.tukivim.res.icons.wk,
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left",
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

    -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
    -- see https://neovim.io/doc/user/map.html#:map-cmd
local vmappings = {
    ["/"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
}

local mappings = {
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    ["q"] = { "<cmd>q<CR>", "Quit" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
    ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
    ["f"] = { "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", "Find File" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["N"] = { "<cmd>Notifications<CR>", "Notify History" },
    b = {
        name = "Buffers",
        j = { "<cmd>BufferPick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        b = { "<cmd>b#<cr>", "Previous" },
        w = { "<cmd>BufferWipeout<cr>", "Wipeout" },
        e = {
            "<cmd>BufferCloseAllButCurrent<cr>",
            "Close all but current",
        },
        h = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
        l = {
            "<cmd>BufferCloseBuffersRight<cr>",
            "Close all to the right",
        },
        D = {
            "<cmd>BufferOrderByDirectory<cr>",
            "Sort by directory",
        },
        L = {
            "<cmd>BufferOrderByLanguage<cr>",
            "Sort by language",
        },
    },
    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        -- r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    t = {
        name = "Trouble",
        t = { "<cmd>Trouble document_diagnostics<cr>", "Document diagnostic" },
        r = { "<cmd>TroubleRefresh<cr>", "Refresh" },
        f = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
        w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace diagnostic" },
        -- j = { "<esc><cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", "Next" },
        -- k = { "<esc><cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", "Previous" },
    },

    -- " Available Debug Adapters:
    -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
    -- " Adapter configuration and installation instructions:
    -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    -- " Debug Adapter protocol:
    -- "   https://microsoft.github.io/debug-adapter-protocol/
    -- " Debugging
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "Undo Stage Hunk",
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)",
        },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Git Diff",
        },
    },

    l = {
        name = "LSP",
        -- a = { "<cmd>lua require('lvim.core.telescope').code_actions()<cr>", "Code Action" },
        d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        j = {
          "<cmd>lua vim.diagnostic.goto_next()<cr>",
          "Next Diagnostic",
        },
        k = {
          "<cmd>lua vim.diagnostic.goto_prev()<cr>",
          "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        -- p = {
        --   name = "Peek",
        --   d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
        --   t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
        --   i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
        -- },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },
    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        p = { "<cmd>Telescope find_project_files<cr>", "Project Files" },
    },
    T = {
        name = "Treesitter",
        i = { ":TSConfigInfo<cr>", "Info" },
    },
}

local wk = vim.tukivim.register("which-key", conf)
wk.register(mappings, opts)
wk.register(vmappings, vopts)