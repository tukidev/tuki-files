local R = {}

local var = {
    "tukivim.var.wkey",
    "tukivim.var.gitsigns",
    "tukivim.var.cmp",
    "tukivim.var.term",
    "tukivim.var.telescope",
    "tukivim.var.ts",
    "tukivim.var.ntree",
    "tukivim.var.bufferline",
    "tukivim.var.autopairs",
    "tukivim.var.comment",
    "tukivim.var.lualine",
}

function R.config(config)
    for _, builtin_path in ipairs(var) do
        local builtin = require(builtin_path)
        builtin.config(config)
    end
end

return R
