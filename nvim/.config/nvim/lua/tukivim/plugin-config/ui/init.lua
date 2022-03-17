---- ---- ---- ---- --
-- USER INTERFACE   --
---- ---- ---- ---- --

local U = require("tukivim.master.source.utils")
local R = require("tukivim.master.res")
local PATH = R.path.config.ui

require(PATH.colorschemes.p).set("catpuccin")       -- set colorscheme

-- setup modules
U.req_list(U.path_to_list(PATH.view.p, require(PATH.view.p)))
