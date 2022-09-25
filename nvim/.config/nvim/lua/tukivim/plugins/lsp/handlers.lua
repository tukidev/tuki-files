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
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

--[[
local capaSnippetSupport = function(capabilities, res)
  capabilities.textDocument.completion.completionItem.snippetSupport = res
  return capabilities
end
]]

return {
	defaults = {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			keymaps.load_module_wk("lsp_wk", "f", bufnr)
			lsp_highlight_document(client)
		end,
	},
}
