---- ----
-- IDE --
---- ----

local R = require("tukivim.master.res")
local PATH = R.path.config.ide

-- setup modules
local completion = require(PATH.cmp.p)
local diagnostic = require(PATH.diagnostic.p)

completion.load()
diagnostic.load()
