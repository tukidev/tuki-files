---- ----
-- IDE --
---- ----

local U = require("tukivim.master.source.utils")
local R = require("tukivim.master.res")
local PATH = R.path.config.ide

-- setup modules
U.req_list(U.path_to_list(PATH.tools.p,      require(PATH.tools.p)     ))
U.req_list(U.path_to_list(PATH.cmp.p,        require(PATH.cmp.p)       ))
U.req_list(U.path_to_list(PATH.diagnostic.p, require(PATH.diagnostic.p)))
