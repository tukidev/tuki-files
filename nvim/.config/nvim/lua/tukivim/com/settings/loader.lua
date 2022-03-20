function Loader()
    local self = {}
    self.config = {}

    function self.set_configuration(config)
        self.config = config or {}
    end


    function self.load()
        -- code
    end



    return self
end


return Loader()
