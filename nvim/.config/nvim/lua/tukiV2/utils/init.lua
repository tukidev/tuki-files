M = {}

---Function that exec format function for selection (visual mode)
M.formatSelection = function()
  vim.lsp.buf.format({
    async = true,
    range = {
			["start"] = vim.api.nvim_buf_get_mark(0, "<"),
			["end"] = vim.api.nvim_buf_get_mark(0, ">"),
		},
  })
end

return M
