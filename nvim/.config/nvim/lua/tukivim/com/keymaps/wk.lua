-- INFO: to be loaded using `which-key` plugin

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

local keymaps = {
	normal_mode = {
		["q"] = { "<cmd>q<CR>", "Quit" },
		["Q"] = { "<cmd>qa!<CR>", "Quit All" },
		["w"] = { "<cmd>w!<CR>", "Save" },
		["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
		["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
		["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
		["N"] = { "<cmd>Notifications<CR>", "Notify History" },
		["m"] = { require("harpoon.mark").add_file, "Add file mark" },
		["M"] = { require("harpoon.mark").rm_file, "Remove file mark" },
		["/"] = { require("Comment.api").toggle.linewise.current, "Comment" },
		["?"] = { require("Comment.api").toggle.blockwise.current, "Comment" },
		b = {
			name = "Buffers",
			j = { "<cmd>BufferPick<cr>", "Jump" },
			f = { "<cmd>Telescope buffers<cr>", "Find" },
			b = { "<cmd>b#<cr>", "Previous" },
			w = { "<cmd>BufferWipeout<cr>", "Wipeout" },
			e = {
				"<cmd>BufferCloseAllButCurrent<cr>",
				"Close all but current",
			},
			h = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
			l = {
				"<cmd>BufferCloseBuffersRight<cr>",
				"Close all to the right",
			},
			D = {
				"<cmd>BufferOrderByDirectory<cr>",
				"Sort by directory",
			},
			L = {
				"<cmd>BufferOrderByLanguage<cr>",
				"Sort by language",
			},
		},
		p = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},
		d = {
			name = "DAP",

			--- [ dap ]
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toogle Repl" },
			l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
			b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint" },
			w = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Widget hover" },
			W = {
				"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<cr>",
				"Widget scope",
			},

			--- [ dap-ui ]
			u = { "<cmd>lua require'dapui'.toggle()<CR>", "Toogle UI" },
		},
		f = {
			name = "Find",
			G = { require("telescope.builtin").git_branches, "Checkout branches" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			f = {
				function()
					require("telescope.builtin").find_files({
						previewer = false,
						hidden = true,
						layout_config = { width = 0.5, height = 20 },
					})
				end,
				"Find File",
			},
			F = {
				function()
					require("telescope.builtin").find_files({
						hidden = true,
					})
				end,
				"Find File Preview",
			},
			g = { require("telescope.builtin").live_grep, "Grep" },
			h = { require("telescope.builtin").help_tags, "Find Help" },
			b = { require("telescope.builtin").buffers, "Buffers" },
			r = { require("telescope.builtin").oldfiles, "Open Recent File" },
			R = { require("telescope.builtin").registers, "Registers" },
			k = { require("telescope.builtin").keymaps, "Keymaps" },
			C = { require("telescope.builtin").commands, "Commands" },
			-- p = { require("telescope.builtin").find_project_files, "Project Files" },
			p = { "<cmd>Telescope projects<cr>", "Project Files" },
			s = {
				function()
					require("telescope").extensions.possession.list({
						previewer = false,
						layout_config = { width = 0.5, height = 20 },
					})
				end,
				"Sessions",
			},
			d = {
				name = "DAP",
				b = { require("telescope").extensions.dap.list_breakpoints, "Breakpoints" },
				k = { require("telescope").extensions.dap.configurations, "Konfigurations" },
				c = { require("telescope").extensions.dap.commands, "Commands" },
				v = { require("telescope").extensions.dap.variables, "Variable" },
				f = { require("telescope").extensions.dap.frames, "Frames" },
			},
			m = { "<cmd>Telescope harpoon marks<cr>", "Marks" },
		},
		G = {
			name = "Git",
			j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			k = { "<gmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
			v = {
				name = "View",
				o = { "<cmd>Telescope git_status<cr>", "View changed file" },
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
				C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
			},
			-- g = { "<cmd>Neogit<cr>", "Open git status" },
			-- c = { "<cmd>Neogit commit<cr>", "Commit" },
			d = { "<cmd>DiffviewOpen<cr>", "Diffview Open" },
			D = { "<cmd>DiffviewClose<cr>", "Diffview Close" },
			h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
			e = { "<cmd>DiffviewToggleFiles<cr>", "Diffview Explorer" },
		},

		l = {
			name = "LSP",

			D = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostic" },
			d = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostic" },
			Q = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
			w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
			f = { vim.lsp.buf.formatting, "Format" },
			i = { "<cmd>LspInfo<cr>", "Info" },
			-- I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
			j = {
				"<cmd>lua vim.diagnostic.goto_next()<cr>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.diagnostic.goto_prev()<cr>",
				"Prev Diagnostic",
			},
			-- l = { require("mason.api.command").Mason, "Mason (Info)" },
			q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
		},

		s = {
			name = "Session",

			s = { require("possession.commands").save, "Save" },
			d = { require("possession.commands").delete, "Delete" },
			l = { require("possession.commands").list, "List" },
			c = { require("possession.commands").close, "Close" },
			i = { require("possession.commands").show, "Show" },
			o = { require("possession.commands").load, "Load" },
		},

		u = {
			name = "UI",

			a = { "<cmd>Alpha<cr>", "Alpha" },
			C = { "<cmd>ColorizerToggle<cr>", "Toggle Colors" },
			c = { "<cmd>CatppuccinCompile<cr>", "Colorscheme Compile" },
			-- z = { "<cmd>TZAttraxis<CR>", "Toggle Zen Mode" },
			-- m = { "<cmd>TZMinimalist<CR>", "Toggle Minimalist Mode" },
			i = { "<cmd>IndentBlanklineToggle<cr>", "Toggle Indent-Blankline" },
			t = { "Telescope colorscheme", "Colorschemes" },
		},
	},
	visual_mode = {
		["/"] = {
			function()
        vim.api.nvim_feedkeys(esc, 'nx', false)
				require("Comment.api").toggle.linewise(vim.fn.visualmode())
			end,
			"Comment",
		},
		["?"] = {
			function()
        vim.api.nvim_feedkeys(esc, 'nx', false)
				require("Comment.api").toggle.blockwise(vim.fn.visualmode())
			end,
			"Comment block",
		},
		-- ["z"] = { "<cmd>'<,'>TZAttraxis<CR>", "Zen"}
	},
}

return keymaps
