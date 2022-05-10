vim.tukivim.utils.psetup('neorg', {
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},

        ["core.gtd.base"] = {
            config = {
                workspace = "notes",
            }
        },

        ["core.norg.dirman"] = {
            config = {
                autochdir = true, -- Automatically change the directory to the current workspace's root every time
                index = "index.norg", -- The name of the main (root) .norg file
                workspaces = {
                    ws    = "~/me/neorg",
                    notes = "~/me/notes",
                    life  = "~/me/notes/life",
                    ent   = "~/me/notes/ent",
                    work  = "~/me/notes/work",
                    dream = "~/me/notes/dream",
                },
                default_workspace = "~/me/notes/life",
            }
        },

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

                            { "<leader>tc", "core.gtd.base.capture" },
                            { "<leader>tt", "core.gtd.base.views" },
                            { "<leader>te", "core.gtd.base.edit" },

                            { "<leader>nn", "core.norg.dirman.new.note" },
                            { "<CR>", "core.norg.esupports.hop.hop-link" },
                            { "<C-CR>", "core.norg.esupports.hop.hop-link", "vsplit" },
                        },
                    }, { silent = true, noremap = true, })


                    -- Map the below keys only when traverse-heading mode is active
                    keybinds.map_event_to_mode("traverse-heading", {
                        n = {
                            { "j", "core.integrations.treesitter.next.heading" },
                            { "k", "core.integrations.treesitter.previous.heading" },
                        },
                    }, { silent = true, noremap = true, })


                    keybinds.map_event_to_mode("toc-split", {
                        n = {
                            { "<CR>", "core.norg.qol.toc.hop-toc-link" },

                            -- Keys for closing the current display
                            { "q", "core.norg.qol.toc.close" },
                            { "<Esc>", "core.norg.qol.toc.close" },
                        },
                    }, { silent = true, noremap = true, nowait = true, })


                    -- Map the below keys on gtd displays
                    keybinds.map_event_to_mode("gtd-displays", {
                        n = {
                            { "<CR>", "core.gtd.ui.goto_task" },

                            -- Keys for closing the current display
                            { "q", "core.gtd.ui.close" },
                            { "<Esc>", "core.gtd.ui.close" },

                            { "e", "core.gtd.ui.edit_task" },
                            { "<Tab>", "core.gtd.ui.details" },
                        },
                    }, { silent = true, noremap = true, nowait = true, })


                    keybinds.map_event_to_mode("presenter", {
                        n = {
                            { "<CR>", "core.presenter.next_page" },
                            { "l", "core.presenter.next_page" },
                            { "h", "core.presenter.previous_page" },

                            -- Keys for closing the current display
                            { "q", "core.presenter.close" },
                            { "<Esc>", "core.presenter.close" },
                        },
                    }, { silent = true, noremap = true, nowait = true, })


                    keybinds.map_to_mode("all", {
                        n = {
                            { "<leader>mn", ":Neorg mode norg<CR>" },
                            { "<leader>mN", ":Neorg mode traverse-heading<CR>" },
                        },
                    }, { silent = true, noremap = true, })

                    keybinds.map("norg", "n", "<leader>tm", "<cmd>Neorg inject-metadata<cr>")
                end,

            }
        },
    }
})
