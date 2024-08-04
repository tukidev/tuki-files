if not require("tukivim.c").extra["obsidian"] then
  return {}
end

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "master",
          path = "~/Workspace/Obsidian/MasterVault",
          overrides = {
            notes_subdir = "0.Slip-Box",
          },
        },
      },
      daily_notes = {
        folder = "Journal/Daily",              -- Optional, if you keep daily notes in a separate directory.
        date_format = "%Y-%m-%d",              -- Optional, if you want to change the date format for the ID of daily notes.
        alias_format = "%B %-d, %Y",           -- Optional, if you want to change the date format of the default alias of daily notes.
        default_tags = { "journal", "daily" }, -- Optional, default tags to add to each new daily note created.
        template = nil                         -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      },
      templates = {
        folder = "_utils/templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {}, -- A map for custom variables, the key should be the variable and the value a function
      },
      attachments = {
        img_folder = "Attachments/Media", -- The default folder to place images in via `:ObsidianPasteImg`.
      },
      mappings = {
        ["g"] = {
          action = function() return require("obsidian").util.gf_passthrough() end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>x"] = {
          action = function() return require("obsidian").util.toggle_checkbox() end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function() return require("obsidian").util.smart_action() end,
          opts = { buffer = true, expr = true },
        }
      },
    },
  }
}
