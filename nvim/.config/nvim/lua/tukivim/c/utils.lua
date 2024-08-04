---@diagnostic disable: need-check-nil
-- local Util = require("lazy.core.util")

local U = {}

function U.preq(plugin_name)
  local ok, plugin = pcall(require, plugin_name)
  if not ok then
    vim.notify("Failed to load [ " .. plugin_name .. " ] module.", vim.log.levels.ERROR)
    return
  end
  return plugin
end

--[[
function U.psetup(plugin_name, config)
  local plugin = U.preq(plugin_name)
  if config then
    plugin.setup(config)
  end
  return plugin
end
--]]

function U.preqlist(plugins)
  plugins = plugins or {}
  for _, it in ipairs(plugins) do
    pcall(require, it)
  end
end

function U.has_value(table, val)
  for _, el in ipairs(table) do
    if val == el then
      return true
    end
  end
  return false
end

-- BUG: error with severities count
U.get_diag_count = function(bufnr)
  local severity = {
    "error",
    "warn",
    "info",
    "hint",
  }

  local diag_count = {}

  local diag_msg = nil
  for _, svr in ipairs(severity) do
    diag_msg = vim.diagnostic.get(bufnr, { severity = svr })
    diag_count[svr] = #diag_msg
  end

  return diag_count
end


---@param plugin string
U.has = function(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end


---@param name string
U.opts = function(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end


---@param name string
---@param fn fun(name:string)
U.on_load = function(name, fn)
  local lazy_conf = require("lazy.core.config")
  if lazy_conf.plugins[name] and lazy_conf.plugins[name]._.loaded then
    vim.schedule(function()
      fn(name)
    end)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end


---@param on_attach fun(client, buffer)
U.on_attach = function(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end


---@param fn fun()
U.on_very_lazy = function(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function() fn() end,
  })
end


---setup lsp server using default capabilities and keymaps
---@param server string name of language server protocol
---@param opts table language server protocol's settings
U.lsp_setup = function(server, opts)
  local lsp_handlers = require("tukivim.plugins.lsp.handlers")

  require("lspconfig")[server].setup(vim.tbl_deep_extend("force", {
    capabilities = lsp_handlers.defaults.capabilities,
    on_attach    = lsp_handlers.defaults.on_attach,
  }, opts))
end


---@param server string language server protocol name
U.lsp_get_config = function(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

---@param server string
---@param cond fun( root_dir, config): boolean
U.lsp_disable = function(server, cond)
  local util = require("lspconfig.util")
  local def = M.lsp_get_config(server)
  def.document_config.on_new_config = util.add_hook_before(
    def.document_config.on_new_config, function(config, root_dir)
      if cond(root_dir, config) then
        config.enabled = false
      end
    end)
end

---Set plugin lazy-loading keys for filetype
---@param name string
---@param ft string
---@param keys string|LazyKeys[]
U.keys_on_lazy_ft = function(name, ft, keys)
  keys = type(keys) == "table" and keys or require("tukivim.c.keymaps").keys(keys)

  U.on_very_lazy(function()
    local buf = vim.api.nvim_win_get_buf(0)
    if (vim.bo[buf].filetype == ft) then
      local plugin = require("lazy.core.config").plugins[name]
      plugin.keys = vim.tbl_deep_extend("force", keys, plugin.keys)
    end
  end)
end


local enabled = true
---Toggle LSP diagnostics
U.toggle_diagnostics = function()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    -- Util.info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    -- Util.warn("Disabled diagnostics", { title = "Diagnostics" })
  end
end


-- delay notifications till vim.notify was replaced or after 500ms
U.lazy_notify = function()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.loop.new_timer()
  local check = vim.loop.new_check()

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end


---Remap keys depending to filetype of buffer is focused
---@param ft string
---@param names string[] names of plugins
U.set_lazy_keys_ft = function(ft, names)
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("tukivim_keys_on_" .. ft),
    pattern = ft,
    callback = function(event)
      for _, pname in ipairs(names) do
        local plugin = require("lazy.core.configs").plugins[pname]
        ---@cast plugin LazyPlugin
        plugin.keys = vim.tbl_deep_extend("force",
          require("tukivim.c.keymaps").keys(pname),
          plugin.keys)
      end
    end
  })
  vim.api.nvim_create_autocmd("BufLeave", {
    group = vim.api.nvim_create_augroup("tukivim_keys_off_" .. ft),
    pattern = ft,
    callback = function(event)
      for _, pname in ipairs(names) do
        local plugin = require("lazy.core.configs").plugins[pname]
        ---@cast plugin LazyPlugin
        plugin.keys = vim.tbl_filter(function(value)
          return vim.tbl_contains(require("tukivim.c.keymaps").keys(pname), value)
        end, plugin.keys)
      end
    end
  })
  vim.cmd([[doau]])
end


return U
