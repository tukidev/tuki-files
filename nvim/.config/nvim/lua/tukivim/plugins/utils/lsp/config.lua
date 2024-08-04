local M         = {}

local UTILS     = require("tukivim.c.utils")
local ICONS     = require("tukivim.c.res.icons")
local LSP_UTILS = require("tukivim.plugins.utils.lsp")

local INIT_LSP  = function()
  -- setup diagnostic signs
  local diag_signs = {
    { name = "DiagnosticSignError", text = ICONS.diagnostic.error },
    { name = "DiagnosticSignWarn",  text = ICONS.diagnostic.warning },
    { name = "DiagnosticSignHint",  text = ICONS.diagnostic.hint },
    { name = "DiagnosticSignInfo",  text = ICONS.diagnostic.info },
  }

  for _, sign in ipairs(diag_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- LSP handlers configuration
  local opts = {
    inlay_hints  = { enabled = true },
    virtual_text = true,
    signs        = { active = diag_signs },
    autoformat   = true,
    diagnostics  = {
      severity_sort    = true,
      underline        = true,
      update_in_insert = false,
      virtual_text     = {
        spacing = 4,
        -- source  = "if_many",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
    },
    float        = {
      focusable = false,
      style     = "minimal",
      border    = "single",
      source    = "always",
      header    = "",
      prefix    = "",
    },
  }

  -- Capabilities

  --[[
  local register_capability = vim.lsp.handlers["client/registerCapability"]
  vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    local ret = register_capability(err, res, ctx)
    local client_id = ctx.client_id
    ---@type lsp.Client
    local client = vim.lsp.get_client_by_id(client_id)
    local buffer = vim.api.nvim_get_current_buf()
    require("tukivim.plugins.utils.lsp").on_attach(client, buffer)
    return ret
  end
  --]]

  -- Hover configuration
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.float)

  -- Signature help configuration
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.float)

  -- Inlay-Hints configuration
  if opts.inlay_hints.enabled then
    TukiVim.lsp.on_supports_method("textDocument/inlayHint", function(_, buffer)
      TukiVim.toggle.inlay_hints(buffer, true)
    end)
    -- UTILS.on_attach(function(client, buffer)
    --   if client.supports_method('textDocument/inlayHint') then inlay_hint(buffer, true) end
    -- end)
  end

  -- Diagnostic configuration
  vim.diagnostic.config(opts.diagnostic)
end


M.setup = function(opts)
  UTILS.on_attach(function(client, bufnr)
    -- require("tukivim.plugins.utils.lsp.format").on_attach(client, bufnr)
    require("tukivim.plugins.utils.lsp").on_attach(client, bufnr)
  end)

  INIT_LSP() -- diagnostics, handlers

  local servers = opts.servers
  local capabilities = LSP_UTILS.completion_capabilities()

  local function server_setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then return end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then return end
    end
    require("lspconfig")[server].setup(server_opts)
  end

  -- Add bun for Node.js-based servers
  --[[
  local lspconfig_util = require "lspconfig.util"
  local add_bun_prefix = require("plugins.lsp.bun").add_bun_prefix
  lspconfig_util.on_setup = lspconfig_util.add_hook_before(lspconfig_util.on_setup, add_bun_prefix)
  --]]

  -- get all the servers that are available through mason-lspconfig
  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        server_setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup { ensure_installed = ensure_installed }
    mlsp.setup_handlers { server_setup }
  end
end

return M
