-- Autocmd User PackerCompileDone to update it every time packer is compiled
vim.api.nvim_create_autocmd("User", {
	pattern = "PackerCompileDone",
	callback = function()
    vim.cmd("CatppuccinClean")
		vim.cmd("CatppuccinCompile")
		vim.defer_fn(function()
			vim.cmd("colorscheme catppuccin")
		end, 0) -- Defered for live reloading
	end,
})

-- PackerCompile on save if your config file is in plugins.lua or catppuccin.lua
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*/plugins/init.lua",},
	callback = function()
		vim.cmd("source <afile> | PackerSync")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = {"*/plugins/colorschemes/catppuccin/init.lua" },
	callback = function()
		vim.cmd("source <afile>")
		vim.cmd("PackerCompile")
	end,
})
