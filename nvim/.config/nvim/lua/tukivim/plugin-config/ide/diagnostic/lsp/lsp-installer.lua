local lsp_installer = vim.tukivim.register("nvim-lsp-installer")
local lsp_path = vim.tukivim.res.path.config.ide.diagnostic.lsp.p

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require(lsp_path .. ".handlers").on_attach,
		capabilities = require(lsp_path .. ".handlers").capabilities,
	}

--	 if server.name == "jsonls" then
--	 	local jsonls_opts = require("tukivim.lsp.settings.jsonls")
--	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
--	 end

    if server.name == "sumneko_lua" then
        local sumneko_opts = require(lsp_path .. ".settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

