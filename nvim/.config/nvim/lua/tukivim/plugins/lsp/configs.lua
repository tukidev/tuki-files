import("lspconfig", function(lspconfig)

	local defaults = {}
	defaults.signs = {
		{ name = "DiagnosticSignError", text = vim.tukivim.res.icons.diagnostic.error },
		{ name = "DiagnosticSignWarn", text = vim.tukivim.res.icons.diagnostic.warning },
		{ name = "DiagnosticSignHint", text = vim.tukivim.res.icons.diagnostic.hint },
		{ name = "DiagnosticSignInfo", text = vim.tukivim.res.icons.diagnostic.info },
	}

	defaults.config = {
		virtual_text = true,
		signs = { active = defaults.signs },
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
	}


	local lspSetup = function(config, signs)
		config = config or defaults.config
		signs = signs or defaults.signs

		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, {
				texthl = sign.name,
				text = sign.text,
				numhl = sign.name,
			})
		end

		vim.diagnostic.config(config)
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{ border = "single" }
		)
	end

	lspSetup(defaults.config, defaults.signs)

  -- load servers
	local servers = require("tukivim.plugins.lsp.servers")
	for server, config in pairs(servers) do
		lspconfig[server].setup(config)
	end
end)
