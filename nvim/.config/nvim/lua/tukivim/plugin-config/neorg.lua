require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},

        ["core.gtd.base"] = {
            config = {
                workspace = "ws",
            }
        },

        ["core.keybinds"] = {
            config = {
                default_keybinds = false,
            }
        },

        ["core.norg.dirman"] = {
            config = {
                autochdir = true, -- Automatically change the directory to the current workspace's root every time
                index = "index.norg", -- The name of the main (root) .norg file
                workspaces = {
                    ws    = "~/me/neorg",
                    life  = "~/me/notes/life",
                    ent   = "~/me/notes/ent",
                    work  = "~/me/notes/work",
                    dream = "~/me/notes/dream",
                },
                default_workspace = "~/me/notes/life",
            }
        }
    }
}
