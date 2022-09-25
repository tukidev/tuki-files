import("alpha", function(alpha)
	local db = vim.tukivim.utils.preq("alpha.themes.dashboard")

	local acsii = vim.tukivim.res.acsii
	db.section.header.val = acsii.pikachu_little

	db.section.buttons.val = {
		db.button("e", "  New file", "<CMD>ene<CR>"),
		db.button("r", "  Recent", "<CMD>Telescope oldfiles<CR>"),
		db.button("f", "  Find file", "<CMD>cd $HOME/workspace | Telescope find_files<CR>"),
		db.button("p", "  Projects", "<CMD>cd $HOME/workspace | Telescope projects<CR>"),
		db.button(
			"s",
			"舘 Sessions",
			"<CMD>Telescope possession list previewer=false layout_config={width=0.5,height=20}<CR>"
		),
		db.button("z", "  Telekasten", "<CMD>cd $HOME/me/tkorg | e index.md<CR><CMD> IndentBlanklineDisable <CR>"),
		db.button("u", "  Update plugins", "<CMD>PackerSync<CR>"),
		db.button("c", "  Configs", "<CMD>e $MYVIMRC | :cd %:p:h <CR>"),
		db.button("q", "  Quit NVIM", "<CMD>qa<CR>"),
	}

	alpha.setup(db.opts)
end)
