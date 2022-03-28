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
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-lua/plenary.nvim' },

    { 'kyazdani42/nvim-tree.lua' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    { 'akinsho/bufferline.nvim' },
    { 'windwp/nvim-autopairs' },         -- Autopairs, integrates with both cmp and treesitter
    { 'numToStr/Comment.nvim' },         -- Easily comment stuff
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'norcalli/nvim-colorizer.lua' },   -- Color view inside Neovim
    { 'ahmedkhalf/project.nvim' },       --
    { 'lukas-reineke/indent-blankline.nvim' },   -- Indent Line
    { 'folke/trouble.nvim' },
    { 'folke/lsp-colors.nvim' },
    { 'folke/todo-comments.nvim' },
    { 'folke/which-key.nvim' },                 -- keymaps helper
    { 'lewis6991/impatient.nvim' },             -- startup-time optimization (cache)
    { 'nathom/filetype.nvim' },                 -- startup-time optimization (adds commands)
    { 'karb94/neoscroll.nvim' },                -- speed smooth scrolling
    { 'rcarriga/nvim-notify' },                 -- pop-up window that notifies processes status
    -- { '' },

    -- cmp
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },                   -- buffer completions
    { 'hrsh7th/cmp-path' },                     -- path completions
    { 'hrsh7th/cmp-cmdline' },                  -- cmdline completions
    { 'saadparwaiz1/cmp_luasnip' },             -- snippet completions
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'akinsho/toggleterm.nvim' },              -- built-in terminal

    -- snippets
    { 'L3MON4D3/LuaSnip' },                     -- snippet engine
    { 'rafamadriz/friendly-snippets' },         -- a bunch of snippets

    -- LSP
    { 'neovim/nvim-lspconfig' },                -- enable LSP
    { 'williamboman/nvim-lsp-installer' },      -- simple way to manage language server installer
    { 'glepnir/lspsaga.nvim' },                 -- additional LSP tools and methods
    { 'jose-elias-alvarez/null-ls.nvim' },      -- null-ls server

    -- debug tools
    { 'mfussenegger/nvim-dap' },
    { 'rcarriga/nvim-dap-ui' },
    { 'mfussenegger/nvim-dap-python' },
    { 'jbyuki/one-small-step-for-vimkind' },    -- `Lua` DAP adapter
    { 'simrat39/rust-tools.nvim' },

    -- Git
    { 'lewis6991/gitsigns.nvim' },
    -- { 'pwntester/octo.nvim', requires = {
    --         'nvim-lua/plenary.nvim',
    --         'nvim-telescope/telescope.nvim',
    --         'kyazdani42/nvim-web-devicons',
    --     },
    -- },


    -- Tree-sitter
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    },


    --- INFO: Color Schemes
    { 'folke/tokyonight.nvim' },
    { 'projekt0n/github-nvim-theme' },
    { 'navarasu/onedark.nvim' },
    { 'olimorris/onedarkpro.nvim' },
    { 'rebelot/kanagawa.nvim' },
    { 'catppuccin/nvim', as = "catppuccin" },
    { 'EdenEast/nightfox.nvim' },

    --- INFO: plugins for neovim version 0.7.0
    -- {
    --     'NarutoXY/dim.lua',
    --     requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" }
    -- },

    -- New another plugins
    {
        'phaazon/hop.nvim', config=function()
            require('tukivim.plugin-config.hop')
        end
    }
    -- {
    --     '', config=function()
    --         require('')
    --     end
    -- }
}

return require("packer").startup(function (use)
    for _, plugin in ipairs(plugins) do
        use(plugin)
    end
end)
