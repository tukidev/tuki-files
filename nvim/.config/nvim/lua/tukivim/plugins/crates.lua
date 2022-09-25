import("crates", function(crates)
	local opts = {
		text = {
			loading = "   Loading ",
			version = "   %s ",
			prerelease = "   %s ",
			yanked = "   %s ",
			nomatch = "   No match ",
			upgrade = "   %s ",
			error = "   Error fetching crate ",
		},
		null_ls = {
			enabled = true,
			name = "crates",
		},
	}

	crates.setup(opts)

	-- CMP source lazy loading
	import("cmp", function(cmp)
		vim.api.nvim_create_autocmd("BufRead", {
			group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
			pattern = "Cargo.toml",
			callback = function()
				cmp.setup.buffer({ sources = { { name = "crates" } } })
			end,
		})
	end)
end)
