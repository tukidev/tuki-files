---- ---- ---- ---- --
-- USER INTERFACE   --
---- ---- ---- ---- --

---- ---- ---- ---- ----
-- Collect list of UI plugin's
-- AND
-- return that list WITH path
---- ---- ---- ---- ----

-- local L = require("tukivim.master.source.loader")
local R = require("tukivim.master.res")
local PATH = R.path.config.ui

-- set colorscheme
require(PATH.colorschemes.p .. ".catpuccin")

-- setup modules
local view = require(PATH.view.p)
local tools = require(PATH.tools.p)

view.load()
tools.load()
