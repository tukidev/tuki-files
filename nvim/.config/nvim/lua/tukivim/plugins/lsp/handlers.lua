-- TODO: rewrite autocmd

local keymaps = vim.tukivim.keymaps

-- Set autocommands conditional on server_capabilities
local function lsp_highlight_document(client)
	if client.server_capabilities.document_highlight then
		vim.pi.nvim_exec(
			[[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]],
			false
		)
	end
end

-- used for `nvim-cmp` plugin
-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

---[[
local capaSnippetSupport = function(capa, b)
  capa.textDocument.completion.completionItem.snippetSupport = b
  return capa
end
--]]

local attach_navic = function(client, bufnr)
	vim.g.navic_silence = true
	import("nvim-navic", function(navic)
		navic.attach(client, bufnr)
	end)
end

return {
	defaults = {
		-- capabilities = capaSnippetSupport(capabilities, true),
		on_attach = function(client, bufnr)
			keymaps.load_module_wk("lsp_wk", "f", bufnr)
      attach_navic(client, bufnr)
			lsp_highlight_document(client)
		end,
	},
}
