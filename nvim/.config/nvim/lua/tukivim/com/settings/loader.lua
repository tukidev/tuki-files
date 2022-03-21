function Loader(configuration)
    local self = {}
    self.config = {}


    function self.setup(config)
        self.config = config or {}
    end


    function self.load()
        for opt, val in pairs(self.config) do
            vim.opt[opt] = val
        end
    end

    self.setup(configuration)
    return self
end

local init = {}
init.setup = function (conf)
    return Loader(conf)
end

return init
