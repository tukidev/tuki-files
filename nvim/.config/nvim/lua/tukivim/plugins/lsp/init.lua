-- TODO: move to another place
local signs = {
	{ name = "DiagnosticSignError", text = vim.tukivim.res.icons.diagnostic.error },
	{ name = "DiagnosticSignWarn", text = vim.tukivim.res.icons.diagnostic.warning },
	{ name = "DiagnosticSignHint", text = vim.tukivim.res.icons.diagnostic.hint },
	{ name = "DiagnosticSignInfo", text = vim.tukivim.res.icons.diagnostic.info },
}

return {
	--#region LSP             | language server protocol (builtin)
	-- ======================================================
	-- ==           LANGUAGE SERVER PROTOCOL               ==
	-- ======================================================
	{
		"neovim/nvim-lspconfig",
		opts = {
			virtual_text = true,
			signs = { active = signs },
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "single",
				source = "always",
				header = "",
				prefix = "",
			},
		},

		config = function(_, opts)
			require("tukivim.plugins.lsp.config").setup(opts)
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		name = "null_ls",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				-- install_root_dir = "/home/tuki/.local/share/nvim/mason",
				ui = {
					icons = {
						package_installed = "✔ ",
						package_pending = " ",
						package_uninstalled = "",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig")
		end,
	},
	-- {
	-- 	"jay-babu/mason-null-ls.nvim",
	-- 	config = function()
	-- 		require("mason-null-ls")
	-- 	end,
	-- },
	{
		"folke/trouble.nvim",
		config = function()
			configure("trouble")
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			import("lsp-inlayhints", function(hints)
				hints.setup()
			end)
		end,
	},
  --[[
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = { "dap" },
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		dependencies = { "dap" },
		config = function()
			configure("rust-tools")
		end,
	},
	{
		"jose-elias-alvarez/typescript.nvim",
		name = "typescript",
		-- ft = "typescript",
	},
  --]]
	--#endregion
}
