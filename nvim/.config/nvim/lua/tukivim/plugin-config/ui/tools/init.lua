---- ---- ---- ---- ---- --
-- UI-TOOLS loader file  --
---- ---- ---- ---- ---- --

local L = require("tukivim.master.source.loader")
local U = require("tukivim.master.source.utils")
local R = require("tukivim.master.res")
local PATH = R.path.config.ui.tools.p
local tools_plugins = {
    "mtelescope",
    "nvim-tree",
    "project",
    "toggleterm",
    "whichkey",
}

local tools_plugins_pathes = U.path_to_list(PATH, tools_plugins)
local ToolsLoader = L:new(tools_plugins_pathes)
ToolsLoader.load()
return ToolsLoader
