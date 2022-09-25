import("bufferline", function(bufferline)
	local ICONS = vim.tukivim.res.icons.bufferline

	bufferline.setup({
		options = {
			-- "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
			numbers = "none",
			close_command = "bdelete! %d", -- can be a string | function
			right_mouse_command = "bdelete! %d", -- can be a string | function
			left_mouse_command = "buffer %d", -- can be a string | function
			middle_mouse_command = nil, -- can be a string | function

			-- icons
      indicator = {
			  icon = ICONS.indicator_icon,
        style = "icon", -- "icon" | "underline" | "none"
      },
			buffer_close_icon = ICONS.buffer_close_icon,
			modified_icon = ICONS.modified_icon,
			close_icon = ICONS.close_icon,
			left_trunc_marker = ICONS.left_trunc_marker,
			right_trunc_marker = ICONS.right_trunc_marker,

			max_name_length = 30,
			max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
			tab_size = 21,
			diagnostics = false, -- | "nvim_lsp" | "coc",
			diagnostics_update_in_insert = false,

			offsets = {
				{ filetype = "NvimTree", text = "    ", padding = 0 },
			},
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
			-- separator_style = 'thin',
			enforce_regular_tabs = true,
			always_show_bufferline = false,
			-- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
			--   -- add custom logic
			--   return buffer_a.modified > buffer_b.modified
			-- end
		},
	})
end)
