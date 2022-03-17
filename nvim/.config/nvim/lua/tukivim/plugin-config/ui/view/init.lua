---- ---- ---- ---- ---- --
-- UI-VIEW plugin loader --
---- ---- ---- ---- ---- --

---- ---- ---- ---- ----
-- Collect list of UI plugin's
-- AND
-- return that list WITH path
---- ---- ---- ---- ----

local L = require("tukivim.master.source.loader")
local U = require("tukivim.master.source.utils")
local R = require("tukivim.master.res")
local PATH = R.path.config.ui.view.p

local view_plugins = {
    "lualine",
    "bufferline",
    "gitsigns",
    "indent-blankline",
    "colorizer",
}

local view_plugins_pathes = U.path_to_list(PATH, view_plugins)
local ViewLoader = L:new(view_plugins_pathes)

-- U.print_list_of_strings(view_plugins_pathes)
ViewLoader.load()
return ViewLoader
