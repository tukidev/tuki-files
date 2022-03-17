local scheme_default = "catpuccin"
local CPATH = require("tukivim.master.res").path.config.ui.colorschemes.p


function ColorScheme()
    local self = {}
    self.scheme = scheme_default


    local function apply()
        pcall(require, CPATH .. '.' .. self.scheme)
    end


    function self.set(colorscheme)
        self.scheme = colorscheme
        apply()
    end


    return self
end

return ColorScheme()
