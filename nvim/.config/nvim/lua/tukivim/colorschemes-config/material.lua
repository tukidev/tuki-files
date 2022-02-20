-- Set the theme style
vim.g.material_style = 'deep ocean'

require('material').setup({
	contrast = {
		sidebars = true,
		floating_windows = true,
	},
	italics = {
		keywords = true,
		functions = true,
	},
	contrast_filetypes = {
		"terminal",
		"packer",
		"qf",
	},
    high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = true -- Enable higher contrast text for darker style
	},
	disable = {
		borders = false,
		eob_lines = true
	}
})

-- Enable style toggling
vim.api.nvim_set_keymap('n', '<leader>ms', ':lua require("material.functions").toggle_style()<CR>', { noremap = true, silent = true })

-- Enable the colorscheme
vim.cmd 'colorscheme material'
