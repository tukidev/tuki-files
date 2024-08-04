local M           = {}

local FORMATTING  = require("null-ls").methods.FORMATTING
local DIAGNOSTICS = require("null-ls").methods.DIAGNOSTICS
local COMPLETION  = require("null-ls").methods.COMPLETION
local CODE_ACTION = require("null-ls").methods.CODE_ACTION
local HOVER       = require("null-ls").methods.HOVER


local list_registered_providers_names = function(ft)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(ft)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end


local attach_navic = function(client, bufnr)
  local ok, navic = pcall(require, "nvim-navic")
  if not ok then return end

  vim.g.navic_silence = true
  navic.attach(client, bufnr)
end


local function lsp_highlight_document(client)
  if client.server_capabilities.document_highlight then
    vim.cmd([[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]])
  end
end



M.list_formatters = function(ft)
  local providers = list_registered_providers_names(ft)
  return providers[FORMATTING] or {}
end


M.list_linters = function(ft)
  local providers = list_registered_providers_names(ft)
  return providers[DIAGNOSTICS] or {}
end


M.list_completions = function(ft)
  local providers = list_registered_providers_names(ft)
  return providers[COMPLETION] or {}
end


M.list_code_actions = function(ft)
  local providers = list_registered_providers_names(ft)
  return providers[CODE_ACTION] or {}
end


M.list_hovers = function(ft)
  local providers = list_registered_providers_names(ft)
  return providers[HOVER] or {}
end


M.completion_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

M.on_attach = function(client, bufnr)
  require("tukivim.c.keymaps").load("lsp-default", bufnr)
  attach_navic(client, bufnr)
  lsp_highlight_document(client)
end


local diagnostics_active = false
M.show_diagnostics = function()
  return diagnostics_active
end


M.toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end


M.opts = function(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then return {} end

  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end


return M
