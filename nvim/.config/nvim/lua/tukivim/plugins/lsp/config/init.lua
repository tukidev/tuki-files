local signs = {
	{ name = "DiagnosticSignError", text = vim.tukivim.res.icons.diagnostic.error },
	{ name = "DiagnosticSignWarn", text = vim.tukivim.res.icons.diagnostic.warning },
	{ name = "DiagnosticSignHint", text = vim.tukivim.res.icons.diagnostic.hint },
	{ name = "DiagnosticSignInfo", text = vim.tukivim.res.icons.diagnostic.info },
}

local lsp_server_path = "tukivim.plugins.lsp.config."
local default_servers = {
	"lua_ls",
	"pyright",
	-- "lemminx",
	-- "marksman",
	-- "jsonls",
	-- "sqlls",
	-- "yamlls",
	-- "eslint",
	-- "angularls",
	-- "html",
	-- "cssls",
	-- "tsserver",
	-- "null_ls",
}

M = {}

M.config = function(opts)
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, {
			texthl = sign.name,
			text = sign.text,
			numhl = sign.name,
		})
	end

	vim.diagnostic.config(opts)
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
end

M.load = function(servers)
	servers = servers or default_servers
	for _, server in ipairs(servers) do
		require(lsp_server_path .. server)
	end
end

M.setup = function(opts)
	M.config(opts)
	-- M.load()
end

return M
