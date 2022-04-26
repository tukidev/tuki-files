local LSPModule = {}
function LSPModule.new()
    local self = {}

    self.lspconfig = vim.tukivim.utils.preq("lspconfig")
    self.settings  = require("tukivim.plugin-config.lsp.settings")
    self.handler = nil
    self.null_ls = nil
    self.saga = nil

    local function setup_handlers()
        self.handler = require("tukivim.plugin-config.lsp.handlers")
        self.handler.setup()
    end

    function self.setup()
        setup_handlers()
        require("tukivim.plugin-config.lsp.lsp-installer").setup(self.handler, self.settings)
        self.null_ls = require("tukivim.plugin-config.lsp.null-ls")
        self.saga = require("tukivim.plugin-config.lsp.saga")
    end


    return self
end


LSPModule.new().setup()
