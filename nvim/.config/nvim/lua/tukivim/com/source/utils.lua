local Utils = {}

function Utils.preq(plugin_name)
	local ok, plugin = pcall(require, plugin_name)
	if not ok then
        vim.notify(
            "Failed to load [ " .. plugin_name .. " ] module.",
            vim.log.levels.ERROR
        )
		return
	end
	return plugin
end

function Utils.psetup(plugin_name, config)
	local plugin = Utils.preq(plugin_name)
	if config then
		plugin.setup(config)
	end
	return plugin
end

function Utils.preqlist(plugins)
	plugins = plugins or {}
	for _, it in ipairs(plugins) do
		pcall(require, it)
	end
end

function Utils.has_value(table, val)
	for _, el in ipairs(table) do
		if val == el then
			return true
		end
	end
	return false
end

return Utils
