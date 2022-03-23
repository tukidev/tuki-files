local status, installer = require("nvim-lsp-installer")
if not status then
    return
end

installer.setup = function (handler, server_settings)
    -- Register a handler that will be called for all installed servers.
    -- Alternatively, you may also register handlers on specific server instances instead (see example below).
    installer.on_server_ready(function(server)
        local opts = {
            on_attach    = handler.on_attach,
            capabilities = handler.capabilities,
        }

        -- Add additional server options for server
        local _opts = server_settings[server.name]
        if _opts then opts = vim.tbl_deep_extend("force", _opts, opts) end

        -- This setup() function is exactly the same as lspconfig's setup function.
        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        server:setup(opts)
    end)
end

return installer
