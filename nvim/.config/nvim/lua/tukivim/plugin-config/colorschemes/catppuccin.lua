local catppuccin = require("catppuccin")

-- configuratoin
catppuccin.setup {
    transparent_background = false,
    term_colors = false,
    styles = {
        comments = "italic",
        functions = "NONE",
        keywords = "bold",
        strings = "italic",
        variables = "NONE",
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = "bold",
                hints = "italic",
                warnings = "NONE",
                information = "italic",
            },
            underlines = {
                errors = "underline",
                hints = "NONE",
                warnings = "underline",
                information = "NONE",
            },
        },
        lsp_trouble = true,
        cmp = true,
        lsp_saga = true,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
        neotree = {
            enabled = false,
            show_root = false,
            transparent_panel = false,
        },
        which_key = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        dashboard = true,
        neogit = false,
        vim_sneak = false,
        fern = false,
        barbar = false,
        bufferline = true,
        markdown = true,
        lightspeed = false,
        ts_rainbow = false,
        hop = true,
        notify = true,
        telekasten = true,
    }
}
--[[
local cp = require("catppuccin.core.color_palette")
local cnf = require("catppuccin.config").options

catppuccin.remap(
    {
        NormalNC = { fg = cp.white, bg = cnf.transparent_background and cp.none or cp.black0 }, -- normal text in non-current windows
		NormalSB = { fg = cp.white, bg = cp.black0 }, -- normal text in non-current windows
        SignColumn = { bg = cnf.transparent_background and cp.none or cp.black1, fg = cp.black4 }, -- column where |signs| are displayed
		SignColumnSB = { bg = cp.black0, fg = cp.black4 }, -- column where |signs| are displayed
    }
)
]]
vim.cmd[[colorscheme catppuccin]]
