local pairs = vim.tukivim.utils.psetup("nvim-autopairs", {
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },

    fast_wrap = {
        map = "<C-s>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
})


--- [ NVIM-CMP intergration ]
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
require("cmp").event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done{
        map_char = { tex = "" }
    }
)

--- [ Custom Rules ]
-- local Rule = require("nvim-autopairs.rule")
-- local cond = require("nvim-autopairs.conds")

-- pairs.add_rules({
--     Rule("--[", "[]]", "lua")
-- })
