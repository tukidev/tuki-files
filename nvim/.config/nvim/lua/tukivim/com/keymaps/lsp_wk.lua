local scope = vim.tukivim.utils.preq("telescope.builtin")

local keymaps = {
	normal_mode = {

		D = { vim.lsp.buf.declaration, "Go declaration" },
    d = { scope.lsp_definitions, "Definitions" },
		i = { scope.lsp_implementations,  "Implementations" },
		o = { vim.lsp.buf.hover, "Hover" },
		r = { scope.lsp_references, "References"},
    s = { vim.lsp.buf.signature_help, "Signature" },
		k = { vim.diagnostic.goto_prev, "Prev (diagnostic)"},
		j = { vim.diagnostic.goto_next, "Next (diagnostic)"},
    f = { vim.diagnostic.open_float, "Diagnostic"},
		a = { vim.lsp.buf.code_action, "Code Action"},
	},

	visual_mode = {
		f = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format" },
		a = { "<cmd>lua vim.lsp.buf.range_code_action()<cr>", "Code Action" },
	},
}

return keymaps
