-- local ok, lspconfig = pcall(require, "lspconfig")
-- if not ok then
--   vim.notify("Error while configuring LSP `lua_ls`", vim.log.levels.ERROR)
--   return
-- end
--
-- local handlers = require("tukivim.plugins.lsp.handlers")
--
-- lspconfig["lua_ls"].setup({
--   capabilities = handlers.defaults.capabilities,
--   on_attach = handlers.defaults.on_attach,
--
--   settings = {
--     Lua = {
--       runtime = { version = "LuaJIT" },
--       diagnostics = { globals = { "vim" } },
--       format = { enable = true },
--       workspace = {
--         -- library = vim.api.nvim_get_runtime_file("", true),
--         library = {
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--           [vim.fn.stdpath("config") .. "/lua"] = true,
--         },
--       },
--       telemetry = { enable = false },
--     },
--   },
-- })

require("tukivim.com.utils").lsp_setup("lua_ls", {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        diagnostics = { globals = { "vim" } },
        format = { enable = true },
        telemetry = { enable = false },
        runtime = { version = 'LuaJIT' },
        workspace = { library = { vim.env.VIMRUNTIME } }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
})
