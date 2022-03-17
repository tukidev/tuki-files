---- ---- ---- ---- ---- ---- --
-- IDE-COMPLETION loader file --
---- ---- ---- ---- ---- ---- --

local L = require("tukivim.master.source.loader")
local U = require("tukivim.master.source.utils")
local R = require("tukivim.master.res")
local PATH = R.path.config.ide.cmp.p

local CMP_plugins = {
    "autopairs",
    "cmp",
    "comment",
}


local CMP_plugins_pathes = U.path_to_list(PATH, CMP_plugins)
local CMPLoader = L:new(CMP_plugins_pathes)
return CMPLoader
