require("nightwolf").setup({
	wolf = "catwolf", -- wolf name (nightwolf, nordwolf, onewolf, nextwolf, catwolf, tokyowolf, forestwolf, gruvwolf, madwolf)
	options = {
		transparent = false, -- if true, background is transparent
		terminal_colors = true, -- if true, set terminal colors
		dim_inactive = true,
		styles = {
			comments = "NONE",
			functions = "NONE", -- TODO: jas``
			keywords = "NONE",
			numbers = "NONE",
			strings = "NONE",
			types = "NONE",
			variables = "NONE",
		},
		inverse = {
			match_paren = false,
			visual = false,
			search = false,
		},
		plugins = {
			bufferline = true,
			cmp = true,
			dashboard = true,
			diagnostic = {
				enable = true,
				background = true,
			},
			gitsigns = true,
			notify = true,
			nvimtree = true,
			telescope = true,
			treesitter = true,
			tsrainbow = true,
			whichkey = true,
		},
	},
})

vim.cmd("colorscheme nightwolf")
