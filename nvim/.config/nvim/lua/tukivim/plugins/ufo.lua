import("ufo", function(ufo)
  -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
	-- vim.o.foldcolumn = "1"
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ("  %d "):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end

	ufo.setup({
		open_fold_hl_timeout = 150,
		preview = {
			win_config = {
				border = { "", "─", "", "", "", "─", "", "" },
				winhighlight = "Normal:Folded",
				winblend = 0,
			},
			mappings = {
				scrollU = "<C-u>",
				scrollD = "<C-d>",
			},
		},
    fold_virt_text_handler = handler,
		provider_selector = function(bufnr, filetype, buftype)
	    -- vim.o.foldlevelstart = 99
		end,
	})

  --- [ keymaps ]
  vim.keymap.set("n", "zO", ufo.openAllFolds, {silent = true, remap = false})
  vim.keymap.set("n", "zI", ufo.closeAllFolds, {silent = true, remap = false})
  vim.keymap.set("n", "zj", ufo.goNextClosedFold, {silent = true, remap = false})
  vim.keymap.set("n", "zk", ufo.goPreviousClosedFold, {silent = true, remap = false})
  vim.keymap.set("n", "zl", ufo.peekFoldedLinesUnderCursor, {silent = true, remap = false})
end)
