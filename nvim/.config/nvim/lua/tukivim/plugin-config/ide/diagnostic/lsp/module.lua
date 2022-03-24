local PATH = vim.tukivim.res.path.config.ide.diagnostic.lsp.p

function LSPModule()
    local self = {}

    self.lspconfig = require("lspconfig")
    self.settings  = require(PATH .. ".settings")
    self.handler = nil
    self.null_ls = nil
    self.saga = nil

    local function setup_handlers()
        self.handler = require(PATH .. ".handlers")
        self.handler.setup()
    end

    function self.setup()
        setup_handlers()
        require(PATH .. ".lsp-installer").setup(self.handler, self.settings)
        self.null_ls = require(PATH .. ".null-ls")
        self.saga = require(PATH .. ".saga")
    end


    return self
end


return LSPModule()
