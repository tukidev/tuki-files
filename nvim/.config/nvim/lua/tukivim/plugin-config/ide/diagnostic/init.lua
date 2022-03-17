---- ---- ---- ---- ---- ---- --
-- UI-DIAGNOSTIC loader file  --
---- ---- ---- ---- ---- ---- --

local L = require("tukivim.master.source.loader")
local U = require("tukivim.master.source.utils")
local R = require("tukivim.master.res")
local PATH = R.path.config.ide.diagnostic.p

local diagnostic_plugins = {
    "lsp",
    "null-ls",
    "treesitter",
    "trouble",
}


local diagnostic_plugins_pathes = U.path_to_list(PATH, diagnostic_plugins)
local DiagLoader = L:new(diagnostic_plugins_pathes)
return DiagLoader
