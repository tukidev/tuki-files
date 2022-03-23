-- vim.tukivim.register("lspconfig")
--
-- --require additional lsp plugins
-- require(PATH .. ".handlers").setup()
-- require(PATH .. ".lsp-installer")
-- require(PATH .. ".saga")

local PATH = vim.tukivim.res.path.config.ide.diagnostic.lsp.p

function LSPModule()
    local self = {}

    self.lspconfig = require("lspconfig")
    self.settings  = require(PATH .. ".settings")
    self.handlers = nil
    self.installer = nil
    self.saga = nil

    local function setup_handlers()
        self.handlers = require(PATH .. ".handlers")
        self.handlers.setup()
    end


    local function setup_installer()
        self.installer = require(PATH .. ".lsp-installer")
        self.lsp_installer.setup()
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
