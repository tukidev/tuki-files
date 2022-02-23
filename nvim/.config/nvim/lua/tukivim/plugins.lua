-- --
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- local packer = require("packer")

local plugins = {
    -- Packer can manage itself
    { 'wbthomason/packer.nvim' },

    -- -- Plugins
    { 'nvim-lua/completion-nvim' },
    { 'kyazdani42/nvim-tree.lua' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'windwp/nvim-autopairs' },         -- Autopairs, integrates with both cmp and treesitter
    { 'numToStr/Comment.nvim' },         -- Easily comment stuff
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'norcalli/nvim-colorizer.lua' },   -- Color view inside Neovim
    { 'ahmedkhalf/project.nvim' },       --

    -- cmp
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },            -- buffer completions
    { 'hrsh7th/cmp-path' },              -- path completions
    { 'hrsh7th/cmp-cmdline' },           -- cmdline completions
    { 'saadparwaiz1/cmp_luasnip' },      -- snippet completions
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'akinsho/toggleterm.nvim' },       -- built-in terminal
    { 'folke/which-key.nvim' },          -- keymaps helper

      -- snippets
    { 'L3MON4D3/LuaSnip' },              --snippet engine
    { 'rafamadriz/friendly-snippets' },  -- a bunch of snippets to {

    -- LSP
    { 'neovim/nvim-lspconfig' },         -- enable LSP
    { 'williamboman/nvim-lsp-installer' },    -- simple to { language server installer

    -- Git
    { 'lewis6991/gitsigns.nvim' },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    },

    -- Tree-sitter
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    },

    -- Lua-line
    {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    },

    -- Buffer Line
    {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    },

    -- Indent Line
    { 'lukas-reineke/indent-blankline.nvim' },

    -- Color Schemes
    { 'folke/tokyonight.nvim' },
    { 'EdenEast/nightfox.nvim' },
    { 'projekt0n/github-nvim-theme' },
    { 'navarasu/onedark.nvim' },
    { 'olimorris/onedarkpro.nvim' },
    { 'rebelot/kanagawa.nvim' },
    { 'catppuccin/nvim', as = "catppuccin" },
}

return require("packer").startup(function (use)
    for _, plugin in ipairs(plugins) do
        use(plugin)
    end
end)


-- return require('packer').startup(function (use)
--     use 'wbthomason/packer.nvim'
--     -- code
-- end)
