---- ---- ---- ---- --
-- USER INTERFACE   --
---- ---- ---- ---- --

local U = require("tukivim.com.source.utils")
local R = require("tukivim.com.res")
local PATH = R.path.config.ui

require(PATH.colorschemes.p).set("catppuccin")       -- set colorscheme

-- setup modules
U.req_list(U.path_to_list(PATH.view.p, require(PATH.view.p)))
