local c = require("catppuccin.core.color_palette")

local theme = {
    normal = {
        a = { fg = c.black2, bg = c.sky },
        b = { fg = c.white, bg = c.grey },
        c = { fg = c.black, bg = c.black },
    },

    insert  = { a = { fg = c.black, bg = c.blue } },
    visual  = { a = { fg = c.black, bg = c.cyan } },
    replace = { a = { fg = c.black, bg = c.red } },

    inactive = {
        a = { fg = c.white, bg = c.black },
        b = { fg = c.white, bg = c.black },
        c = { fg = c.black, bg = c.black },
    },
}


local el_opts_a = {
    separator = { left = '', right = '' },
    padding = { left = 2, right = 2 },
}




vim.tukivim.utils.psetup("lualine", {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = {
            {
                "mode",
                separator = { left = '', right = '' },
            },
        },
		lualine_b = {
            { "branch" } ,
            { "diff"},
            { "diagnostics" },
        },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { { "location", separator = { left = '', right = '' } }, },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
