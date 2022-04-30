local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local plugins = {
	-- Packer can manage itself
	{ "wbthomason/packer.nvim" },

	-- Requiring Plugins
	{ "kyazdani42/nvim-web-devicons" },
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },

	{ "lewis6991/impatient.nvim" }, -- startup-time optimization (cache)
	{ "nathom/filetype.nvim" }, -- startup-time optimization (adds commands)

	--- [ LSP ]                      | (built-in Language Server Protocols)
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("tukivim.plugin-config.lsp")
		end,
	},
	{ "williamboman/nvim-lsp-installer" },
	{ "glepnir/lspsaga.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" },

	--- [ CMP ]                      | (completion & snippets & it's sources)
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("tukivim.plugin-config.cmp")
		end,

		--  #Snippets
	},
	{ "L3MON4D3/LuaSnip" },
	{
		"rafamadriz/friendly-snippets", -- a bunch of snippets
		--  #Sources
	},
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "saadparwaiz1/cmp_luasnip" },

	--- [ Telescope ]                | (modern `fzf` plugin)
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("tukivim.plugin-config.telescope")
		end,
	},
	{ "nvim-telescope/telescope-dap.nvim" },
	{ "FeiyouG/command_center.nvim" },

	--- [ DAP ]                      | (Debug Adapter Protocols)
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("tukivim.plugin-config.dap")
		end,
	},
	{ "theHamsta/nvim-dap-virtual-text" },
	{
		"rcarriga/nvim-dap-ui",
		-- #DAPTools
	},
	{ "mfussenegger/nvim-dap-python" },
	{ "simrat39/rust-tools.nvim" },

	-- { 'jbyuki/one-small-step-for-vimkind' },    -- `Lua` DAP adapter

	--- [ TS ]                       | (Tree-sitter [syntax highlighting])
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("tukivim.plugin-config.treesitter")
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },

	--- INFO: plugins for neovim version 0.7.0
	-- {
	--     'NarutoXY/dim.lua',
	--     requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" }
	-- },

	--- [ Others ]
	{
		"phaazon/hop.nvim",
		config = function()
			require("tukivim.plugin-config.hop")
		end,
	},
	{
		"beauwilliams/focus.nvim",
		config = function()
			require("tukivim.plugin-config.focus")
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("tukivim.plugin-config.dressing")
		end,
	},
	{
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("tukivim.plugin-config.neogit")
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("tukivim.plugin-config.diffview")
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("tukivim.plugin-config.neoscroll")
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("tukivim.plugin-config.autopairs")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("tukivim.plugin-config.comment")
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			require("tukivim.plugin-config.trouble")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("tukivim.plugin-config.whichkey")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("tukivim.plugin-config.toggleterm")
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("tukivim.plugin-config.notify")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("tukivim.plugin-config.nvim-tree")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("tukivim.plugin-config.lualine")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("tukivim.plugin-config.bufferline")
		end,
	},
	{
		"folke/lsp-colors.nvim",
		config = function()
			require("tukivim.plugin-config.lsp-colors")
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("tukivim.plugin-config.todo-comments")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("tukivim.plugin-config.indent-blankline")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("tukivim.plugin-config.project")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("tukivim.plugin-config.colorizer")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("tukivim.plugin-config.gitsigns")
		end,
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("tukivim.plugin-config.zen")
		end,
	},
	{
		"ur4ltz/surround.nvim",
		config = function()
			require("tukivim.plugin-config.surround")
		end,
		-- },{
		--     '', config=function()
		--         require('tukivim.plugin-config.')
		--     end
		-- },{
		--     '', config=function()
		--         require('tukivim.plugin-config.')
		--     end
		-- },{
		--     'sunjon/shade.nvim', config=function()
		--         require("tukivim.plugin-config.shade")
		--     end
	},

	-- Color Schemes
	{ "folke/tokyonight.nvim" },
	{ "projekt0n/github-nvim-theme" },
	{ "navarasu/onedark.nvim" },
	{ "olimorris/onedarkpro.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "catppuccin/nvim", as = "catppuccin" },
	{ "EdenEast/nightfox.nvim" },
	{ "z4yw0o/nightwolf.nvim" },
}

return require("packer").startup(function(use)
	for _, plugin in ipairs(plugins) do
		use(plugin)
	end
end)
