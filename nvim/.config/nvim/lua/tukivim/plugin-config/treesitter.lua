vim.tukivim.utils.preq("nvim-treesitter")

require("nvim-treesitter.configs").setup({
	ensure_installed = "all", -- one of "all", or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = { enable = true },
	indent = {
		enable = true,
		disable = { "yaml" },
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
