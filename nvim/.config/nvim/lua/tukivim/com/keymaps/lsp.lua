local scope = vim.tukivim.utils.preq("telescope.builtin")

local keymaps = {
	normal_mode = {

		-- builtin LSP
		["fD"] = vim.lsp.buf.declaration,
    ["fd"] = scope.lsp_definitions,
		["fi"] = scope.lsp_implementations,
		["fo"] = vim.lsp.buf.hover,
		["fr"] = scope.lsp_references,
    ["fs"] = vim.lsp.buf.signature_help,
		["fk"] = vim.diagnostic.goto_prev,
		["fj"] = vim.diagnostic.goto_next,
    ["ff"] = vim.diagnostic.open_float,
		["fa"] = vim.lsp.buf.code_action,

		-- saga LSP
		-- ["fa"] = require("lspsaga.codeaction").code_action,
  --   ["ff"] = require("lspsaga.finder").lsp_finder,
  --   ["fp"] = require("lspsaga.definition").preview_definition,
  --   ["fs"] = require("lspsaga.signaturehelp").signature_help,
		-- ["fj"] = require("lspsaga.diagnostic").goto_next,
		-- ["fk"] = require("lspsaga.diagnostic").goto_prev,
		-- ["fJ"] = function()
		-- 	require("lspsaga.diagnostic").goto_next({
		-- 		severity = vim.diagnostic.severity.ERROR,
		-- 	})
		-- end,
		-- ["fK"] = function()
		-- 	require("lspsaga.diagnostic").goto_prev({
		-- 		severity = vim.diagnostic.severity.ERROR,
		-- 	})
		-- end,
	},

	visual_mode = {

		-- saga LSP
		-- ["fa"] = function()
		-- 	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
		-- 	require("lspsaga.codeaction").range_code_action()
		-- end,
	},
}

return keymaps
