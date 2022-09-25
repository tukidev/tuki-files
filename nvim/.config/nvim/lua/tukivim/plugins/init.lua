-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.notify("Installing packer close and reopen Neovim...", "info", { render = "minimal" })
	vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	auto_reload_compiled = true,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
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
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing")
		end,
	},

	--- [ LSP ]                      | (built-in Language Server Protocols)
	{
		"neovim/nvim-lspconfig",
		config = function()
			configure("lsp")
		end,
	},
	{ "jose-elias-alvarez/null-ls.nvim", as = "null_ls" },
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		after = "dap",
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		after = { "dap" },
		config = function()
			configure("rust-tools")
		end,
	},

	--- [ CMP ]                      | (completion & snippets & it's sources)
	{
		"hrsh7th/nvim-cmp",
		as = "cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			configure("cmp")
		end,
	},
	--  #Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },
	--  #Sources
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua", ft = { "lua" } },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "lukas-reineke/cmp-under-comparator" },
	{ "lukas-reineke/cmp-rg" },
	-- { "hrsh7th/cmp-nvim-lsp-signature-help" },
	-- { "tzachar/cmp-tabnine" },

	--- [ Telescope ]                | (modern `fzf-search` plugin)
	{
		"nvim-telescope/telescope.nvim",
		as = "scope",
		config = function()
			configure("telescope")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		after = "scope",
		run = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		after = "scope",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		after = { "scope", "dap" },
		config = function()
			require("telescope").load_extension("dap")
		end,
	},

	--- [ DAP ]                      | (Debug Adapter Protocols)
	{
		"mfussenegger/nvim-dap",
		as = "dap",
		ft = { "c", "cpp", "rust", "java", "lua", "python" },
		config = function()
			configure("dap")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		after = "dap",
		config = function()
			configure("dap.virt")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		after = "dap",
		config = function()
			configure("dap.ui")
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		after = "dap",
		config = function()
			import("dap-python", function(dappy)
				dappy.setup("/opt/miniconda3/bin/python")
			end)
		end,
	},

	--- [ TS ]                       | (Tree-sitter [syntax highlighting])
	{
		"nvim-treesitter/nvim-treesitter",
		as = "treesitter",
		-- commit = "9b3f1275018b7cac15ef07af880e1f010a959963",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			import("nvim-treesitter", function(_)
				require("nvim-treesitter.configs").setup({
					ensure_installed = "all",
					auto_install = true,
					sync_install = true,
					autopairs = { enable = true },
					-- context_commentstring = {
					-- 	enable = true,
					-- 	enable_autocmd = false,
					-- },
					highlight = { enable = true },
				})
			end)
		end,
	},
	-- { "JoosepAlviste/nvim-ts-context-commentstring" },

	--- [ Others ]
	{
		"saecki/crates.nvim",
		-- tag = "v0.2.1",
		event = { "BufRead Cargo.toml" },
		after = { "null_ls", "cmp" },
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			configure("crates")
		end,
	},
	{
		"zbirenbaum/neodim",
		config = function()
			configure("neodim")
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			import("hop", function(hop)
				hop.setup()
			end)
		end,
	},
	{
		"beauwilliams/focus.nvim",
		config = function()
			import("focus", function(focus)
				focus.setup({
					signcolumn = false,
					excluded_filetypes = { "toggleterm" },
					compatible_filetrees = { "nvimtree" },
				})
			end)
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			import("neoscroll", function(scroll)
				scroll.setup({})
			end)
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			configure("autopairs")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			configure("comment")
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			configure("trouble")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			configure("whichkey")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			configure("toggleterm")
		end,
	},
	{
		"rcarriga/nvim-notify",
		after = "scope",
		config = function()
			configure("notify")
			require("telescope").load_extension("notify")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			configure("nvim-tree")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			configure("lualine")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			configure("bufferline")
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			configure("todo-comments")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			import("indent_blankline", function(blankline)
				vim.g.indent_blankline_char = "│"
				blankline.setup({
					show_current_context = true,
					filetype_exclude = {
            "help",
						"dashboard",
						"alpha",
						"markdown",
						"telekasten",
						"org",
						"norg",
					},
				})
			end)
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			configure("project")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			import("colorizer", function(colorizer)
				colorizer.setup({ "*" }, { mode = "background" })
			end)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			configure("gitsigns")
		end,
	},
	{
		"ur4ltz/surround.nvim",
		config = function()
			configure("surround")
		end,
	},
	{
		"renerocksai/telekasten.nvim",
		ft = { "md", "markdown", "telekasten" },
		config = function()
			configure("telekasten")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			configure("harpoon")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			configure("alpha")
		end,
	},
	{
		"jedrzejboczar/possession.nvim",
		config = function()
			configure("possession")
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			configure("ufo")
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			import("illuminate", function(illuminate)
				illuminate.configure({
					providers = { "lsp", "treesitter", "regex" },
					delay = 200,
					under_cursor = true,
				})
			end)
		end,
	},
  {
    "tversteeg/registers.nvim",
    config = function ()
      vim.g.registers_delay = 100
      vim.g.registers_window_border = "single"
      vim.g.registers_show_empty_registers = 0
      vim.g.registers_hide_only_whitespace = 1
      vim.g.registers_show = "*+-\"qwertyasdfgQWERTYASDFG"
    end
  },
	--[[
	{
		"phaazon/mind.nvim",
		config = function()
			configure("mind")
		end,
	},
  {
		"stevearc/overseer.nvim",
		config = function()
      configure("overseer")
		end,
	},
  --]]

	-- ColorSchemes               | uncomment ONE of them to use colorscheme
	{
		"catppuccin/nvim",
		as = "catppuccin",
		run = ":CatppuccinCompile",
		config = function()
			configure("colorschemes.catppuccin")
		end,
	},
	-- { "folke/tokyonight.nvim" },
	-- { "projekt0n/github-nvim-theme" },
	-- { "navarasu/onedark.nvim" },
	-- { "olimorris/onedarkpro.nvim" },
	-- { "rebelot/kanagawa.nvim" },
	-- { "EdenEast/nightfox.nvim" },
	-- { "z4yw0o/nightwolf.nvim" },
}

return require("packer").startup(function(use)
	-- First start `impatient` plugin to use cache
	---[[
	use({
		"lewis6991/impatient.nvim",
		-- config = function()	require("impatient") end,
	})
	--]]

	-- Load all plugins
	for _, plugin in ipairs(plugins) do
		use(plugin)
	end

	-- Automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
