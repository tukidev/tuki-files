-- local log_timestamp_format = '%Y-%m-%d %H:%M:%S'

--------------------
-- Manager Define --
--------------------

local config_dir = "tukivim.plugins."
local notify_opts = {
  title = "NEOMAN",
  icon = " ",
}

local M = {}

-- TODO: UI : failed, success, info, interface
-- TODO: API : load, reload, disable, go_to_config
M.init = function()
  local self = {}
  -- self.plugins = {}
  -- self.plugins.success = {}
  -- self.plugins.failed = {}

  ---setup function
  ---@param opts table
  self.init = function(opts)
    _G.import = self.import
    _G.configure = self.configure
  end

  ---require plugin in safe mode and run callback after successfull requiring
  ---@param name string plugin-name as you use in `require` function
  ---@param callback function run if plugin requiring was successfull
  ---@param opts table
  ---@return nil
  self.import = function(name, callback, opts)
    opts = opts or {}

    if not name then
      vim.notify("neoman.import(...) called with NO arguments.", "warn", notify_opts)
      return
    end

    local module_ok, module = pcall(require, name)
    if not module_ok then
      vim.notify("Plugin `" .. name .. "` is not exist.", "warn", notify_opts)
      table.insert(self.plugins.failed, name)
      return
    end

    if not callback then
      return
    end

    local callback_ok = pcall(callback, module)
    if not callback_ok then
      vim.notify("Can't call callback function for plugin `" .. name .. "`.", "warn", notify_opts)
    end
  end

  self.configure = function(path)
    if not pcall(require, config_dir .. path) then
      vim.notify("Config path [[ " .. config_dir .. path .. " ]] does not exist.", "error", notify_opts)
    end
  end

  return self
end

return M.init()
