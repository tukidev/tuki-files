local PATH = vim.tukivim.res.path.config.ide.diagnostic.lsp.p

function LSPModule()
    local self = {}

    self.lspconfig = require("lspconfig")
    self.settings  = require(PATH .. ".settings")
    self.handler = nil
    self.saga = nil

    local function setup_handlers()
        self.handler = require(PATH .. ".handlers")
        self.handler.setup()
    end


    local function setup_installer()
        local installer = require(PATH .. ".lsp-installer")
        installer.setup(self.handler, self.settings)
    end


    local function setup_saga()
        self.saga = require(PATH .. ".saga")
    end


    function self.setup()
        setup_handlers()
        setup_installer()
        setup_saga()
    end


    return self
end


return LSPModule()
