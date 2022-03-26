local PATH = "tukivim.plugin-config.ide.tools.dap.lang"
local Utils = vim.tukivim.utils

local langs = {
    "dap-lua",
    -- "dap-python",
    -- "dap-rust",
    -- "dap-cpp",
    -- "",
}

Utils.req_list(Utils.path_to_list(PATH, langs))
