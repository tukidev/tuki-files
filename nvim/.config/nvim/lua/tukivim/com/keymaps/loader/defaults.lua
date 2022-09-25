local M = {}
M.prefix = " " -- set default prefix as space

---Default options for `insert` and `normal` modes
M.opts_wk = function(prefix, buf)
	prefix = prefix or M.prefix
	return {
		insert_mode = { -- standart opts
			mode = "i",
			prefix = prefix,
			buffer = buf,
			silent = true,
			remap = false,
			nowait = true,
		},
		normal_mode = {
			mode = "n",
			prefix = prefix,
			buffer = buf,
			silent = true,
			remap = false,
			nowait = true,
		},
		visual_mode = {
			mode = "v",
			prefix = prefix,
			buffer = buf,
			silent = true,
			remap = false,
			nowait = true,
		},
	}
end

M.opts = { noremap = true, silent = true }
M.mode_opts = {
	insert_mode = M.opts,
	normal_mode = M.opts,
	visual_mode = M.opts,
	command_mode = M.opts,
	visual_block_mode = M.opts,
	term_mode = { silent = true },
}

M.opts2 = {
	remap = true,
	silent = true,
	buffer = 0,
}
M.mode_opts2 = {
	insert_mode = M.opts,
	normal_mode = M.opts,
	visual_mode = M.opts,
	command_mode = M.opts,
	visual_block_mode = M.opts,
	term_mode = { silent = true },
}
M.opts2_of = function(buffer)
	return {
		remap = true,
		silent = true,
		buffer = buffer,
	}
end

M.mode_adapters = {
	insert_mode = "i",
	normal_mode = "n",
	term_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

return M
