--- [ Options ]
vim.g.nvim_tree_root_folder_modifier = ":t"
vim.g.nvim_tree_git_hl = true
vim.g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}

local icons = vim.tukivim.res.icons
vim.g.nvim_tree_icons = {
	default = icons.objects.file,
	symlink = icons.folder.symlink,
	git = {
		unstaged = icons.git.unstaged,
		staged = icons.git.staged,
		unmerged = icons.git.unmerged,
		renamed = icons.git.renamed,
		deleted = icons.git.deleted_c,
		untracked = icons.git.untracked,
		ignored = icons.git.ignored,
	},
	folder = {
		default = icons.folder.default,
		open = icons.folder.open,
		empty = icons.folder.empty,
		empty_open = icons.folder.empty_open,
		symlink = icons.folder.symlink,
	},
}

--- [ remap highlight groups ]
vim.cmd([[ highlight NvimTreeGitNew guifg = #DDB6F2 ]])
vim.cmd([[ highlight NvimTreeGitStaged guifg = #ABE9B3 ]])


local tree = vim.tukivim.utils.preq("nvim-tree")
local tree_cb = vim.tukivim.utils.preq("nvim-tree.config").nvim_tree_callback

tree.setup({
	auto_reload_on_write = true,
	disable_netrw = false,
	hijack_netrw = true,
	open_on_setup = false,

	renderer = {
		indent_markers = {
			enable = false,
			icons = {
				edge = "│ ",
				corner = "└ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
		},
	},

	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	-- auto_close = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = icons.diagnostic.hint,
			info = icons.diagnostic.info,
			warning = icons.diagnostic.warning,
			error = icons.diagnostic.error,
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 35,
		height = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
		number = false,
		relativenumber = false,
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		change_dir = {
			enable = true,
			global = false,
		},

		open_file = {
			quit_on_open = true,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
})
