local UTILS = require("tukivim.c.utils")
local ICONS = require("tukivim.c.res.icons")
local KEYMAPS = require("tukivim.c.keymaps")

return {
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "nui.nvim", "nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = false,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = { { find = "%d+L, %d+B" }, { find = "; after #%d+" }, { find = "; before #%d+" } },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      cmdline = {
        format = {
          search_down = { icon = ".  " },
          search_up = { icon = ".  " },
        },
      },

    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("tukivim.c.res.icons").bufferline
      local custom_hl = require("tukivim.plugins.utils.colorschemes.catppuccin.bufferline").get()
      return {
        highlights = custom_hl,
        options = {
          close_command          = function(n) require("mini.bufremove").delete(n, false) end,
          left_mouse_command     = function(n) require("mini.bufremove").delete(n, false) end,

          -- icons
          indicator              = { icon = icons.indicator_icon },
          buffer_close_icon      = icons.buffer_close_icon,
          modified_icon          = icons.modified_icon,
          close_icon             = icons.close_icon,
          left_trunc_marker      = icons.left_trunc_marker,
          right_trunc_marker     = icons.right_trunc_marker,

          offsets                = { { filetype = "NvimTree", text = "    ", text_align = "center" } },
          separator_style        = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
          enforce_regular_tabs   = true,
          always_show_bufferline = false,
          hover                  = { delay = 100 },
        },
      }
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)
      KEYMAPS.load("bufferline")
    end
  },
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = KEYMAPS.keys("mini-bufremove"),
    config = function()
      require("mini.bufremove").setup()
      KEYMAPS.load("mini-bufremove")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-navic" },
    opts = function()
      local components = require("tukivim.plugins.utils.lualine.theme").components
      local statusline = {
        lualine_a = {
          components.mode_indicator,
          components.mode_label,
        },
        lualine_b = {},
        lualine_c = {
          components.File.name,
          components.GIT.branch,
          components.GIT.diff,
        },

        lualine_x = {
          -- components.python_environment,
          components.LSP.diag,
          components.LSP.name,
          components.File.type,
          components.Carret.percent,
          components.Carret.location,
        },
        lualine_y = {},
        lualine_z = {},
      }
      local winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = { components.winbar.file, components.winbar.navic },
      }

      return {
        options         = {
          icons_enabled = true,
          theme = require("tukivim.plugins.utils.lualine.theme").theme,
          always_divide_middle = true,
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "alpha" },
            winbar = { "alpha", "NvimTree" },
          },
        },
        sections        = statusline,
        winbar          = winbar,
        inactive_winbar = winbar,
      }
    end,
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      UTILS.on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = {
      highlight = true,
      separator = "  ",
      depth_limit = 4,
      depth_limit_indicator = "...",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
    keys = KEYMAPS.keys("nvim-tree"),
    opts = {
      auto_reload_on_write = true,
      disable_netrw = true,
      select_prompts = true,

      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return {
            desc = "Nvim-Tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.del('n', '<C-x>', { buffer = bufnr })

        -- custom mappings
        vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
      end,

      update_focused_file = { enable = true },

      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = 45,
        side = "left",
        preserve_window_proportions = true,
        signcolumn = "yes",
      },
      renderer = {
        add_trailing = false,
        group_empty = true,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        highlight_modified = "none",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = { enable = false },
        icons = {
          webdev_colors = true,
          git_placement = "after",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = "  ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open   = "",
              default      = "",
              open         = "",
              empty        = "",
              empty_open   = "",
              symlink      = "",
              symlink_open = "",
            },
            git = {
              unstaged  = "",
              staged    = "󰡕",
              unmerged  = "",
              renamed   = "󰧂",
              untracked = "",
              deleted   = "",
              ignored   = "",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        git_ignored = false,
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
      },
      actions = {
        use_system_clipboard = true,
        remove_file = { close_window = true },
        open_file = {
          quit_on_open = true,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "FJDKSLVNCM",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      trash = { cmd = "gio trash" },
    },
    config = function(_, opts)
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      require("nvim-tree").setup(opts)
      KEYMAPS.load("nvim-tree")
    end,
  },
  {
    "folke/which-key.nvim",
    -- event = "VeryLazy",
    keys = { "<leader>", "f", "s", "z", "[", "]" },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      win = {
        title = false,
        -- border = "none",    -- none, single, double, shadow
        padding = { 2, 2 }, -- extra window padding [top, right, bottom, left]
        -- wo = { winblend = 0 }

      },
      layout = {
        -- height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 4,                    -- spacing between columns
        -- align = "left",
      },
      show_help = false,
      show_keys = false,
      debug = false,
      spec = {
        { "<leader>d", group = "[D]AP", icon = { icon = "", color = "red" } },
        { "<leader>D", group = "[D]atabase", icon = { icon = "", color = "azure" } },
        { "<leader>s", group = "[s]earch", icon = { icon = "", color = "blue" } },
        { "<leader>S", group = "[S]pectre", icon = { icon = "󱡴", color = "purple" } },
        { "<leader>g", group = "[G]it", icon = { icon = "", color = "red" } },
        { "<leader>u", group = "[U]I", icon = { icon = "", color = "azure" } },
        { "<leader>t", group = "[t]ests", icon = { icon = "󰙨", color = "red" } },
        { "<leader>v", group = "[V]im", icon = { icon = "", color = "green" } },
        { "<leader>vs", group = "[S]ession", icon = { icon = "", color = "blue" } },
        { "<leader>l", group = "[L]SP", icon = { icon = "", color = "grey" } },
        { "<leader>m", group = "[M]arks", icon = { icon = "", color = "orange" } },
      }
    },
    -- config = function(_, opts)
    --   local wk = require("which-key")
    --   wk.setup(opts)
    -- end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    keys = KEYMAPS.keys("notify"),
    opts = {
      stages = "fade",    -- Animation style (see below for details)
      render = "default", -- Render function for notifications. See notify-render()
      timeout = 3000,     -- Default timeout for notifications
      on_open = nil,      -- Function called when a new window is opened, use for changing win settings/config
      on_close = nil,     -- Function called when a window is closed
      max_width = nil,
      max_height = nil,
      minimum_width = 42,
      icons = ICONS.notify,
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
      KEYMAPS.load("notify")
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local db = require("alpha.themes.dashboard")

      db.section.header.val = require("tukivim.c.res.acsii").pikachu_little

      db.section.buttons.val = {
        db.button("r", " " .. " Recent", "<cmd>Telescope oldfiles<cr>"),
        db.button("n", " " .. " New file", "<cmd>ene<cr>"),
        db.button("f", " " .. " Find file", "<cmd>cd $HOME/workspace | Telescope find_files<cr>"),
        db.button("s", "󰁯 " .. " Restore Session", "<cmd>lua require('persistence').load()<cr>"),
        db.button("p", " " .. " Projects", "<cmd>cd $HOME/workspace | Telescope projects<cr>"),
        db.button("c", " " .. " Configs", "<cmd>e $MYVIMRC | :cd %:p:h <cr>"),
        db.button("l", "󰒲 " .. " Lazy", "<cmd>Lazy<cr>"),
        db.button("q", " " .. " Quit NeoVim", "<cmd>qa<cr>"),
      }

      for _, button in ipairs(db.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      db.section.header.opts.hl = "AlphaHeader"
      db.section.buttons.opts.hl = "AlphaButtons"
      db.section.footer.opts.hl = "AlphaFooter"

      return db
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
