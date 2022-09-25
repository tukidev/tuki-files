import("neorg", function(neorg)
	neorg.setup({
		load = {
			["core.defaults"] = {},

			["core.norg.dirman"] = {
				config = {
					autochdir = true, -- Automatically change the directory to the current workspace's root every time
					workspaces = {
						root = "$HOME/me/norg",
						journal = "$HOME/me/norg/journal",
						wiki = "$HOME/me/norg/wiki",
					},
					default_workspace = "root",
					index = "index.norg",
				},
			},

			["core.norg.manoeuvre"] = { config = {} },
			["core.norg.concealer"] = { config = {} },

			["core.norg.journal"] = {
				config = {
					workspace = "journal",
					journal_folder = "journal",
					strategy = "flat",
				},
			},

			["core.norg.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},

			["core.integrations.nvim-cmp"] = { config = {} },

			["core.keybinds"] = {
				config = {
					default_keybinds = false,
					hook = function(keybinds)
						keybinds.map_event_to_mode("norg", {
							n = {
								{ "td", "core.norg.qol.todo_items.todo.task_done" },
								{ "tD", "core.norg.qol.todo_items.todo.task_undone" },
								{ "tt", "core.norg.qol.todo_items.todo.task_pending" },
								{ "th", "core.norg.qol.todo_items.todo.task_on_hold" },
								{ "tc", "core.norg.qol.todo_items.todo.task_cancelled" },
								{ "tr", "core.norg.qol.todo_items.todo.task_recurring" },
								{ "ti", "core.norg.qol.todo_items.todo.task_important" },
								{ "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" },

								{ "<leader>nn", "core.norg.dirman.new.note" },
								{ "<CR>", "core.norg.esupports.hop.hop-link" },
								{ "<C-CR>", "core.norg.esupports.hop.hop-link", "vsplit" },
							},
						}, { silent = true, noremap = true })

						keybinds.map_event_to_mode("toc-split", {
							n = {
								{ "<CR>", "core.norg.qol.toc.hop-toc-link" },

								-- Keys for closing the current display
								{ "q", "core.norg.qol.toc.close" },
								{ "<Esc>", "core.norg.qol.toc.close" },
							},
						}, { silent = true, noremap = true, nowait = true })

						keybinds.map("norg", "n", "<leader>tm", "<cmd>Neorg inject-metadata<cr>")
					end,
				},
			},
		},
	})
end)
