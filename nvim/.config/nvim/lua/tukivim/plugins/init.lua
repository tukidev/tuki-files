local utils = require("tukivim.com.utils")

-- TODO: move to another place
local signs = {
  { name = "DiagnosticSignError", text = vim.tukivim.res.icons.diagnostic.error },
  { name = "DiagnosticSignWarn",  text = vim.tukivim.res.icons.diagnostic.warning },
  { name = "DiagnosticSignHint",  text = vim.tukivim.res.icons.diagnostic.hint },
  { name = "DiagnosticSignInfo",  text = vim.tukivim.res.icons.diagnostic.info },
}

--#region BOOTSTRAPING `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  vim.notify("Installing `lazy.nvim` close and reopen Neovim...", vim.log.levels.INFO, { render = "minimal" })
end
vim.opt.rtp:prepend(lazypath)
--#endregion

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local PLUGINS = {
  --#region PREREQUIRED PLUGINS LIBRARIES
  -- ======================================================
  -- ==          REQUIRED BY OTHER PLUGINS               ==
  -- ======================================================
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim",      lazy = true },
  { "MunifTanjim/nui.nvim",       lazy = true },
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
  --#endregion

  --#region OTHERS
  -- ======================================================
  -- ==                    OTHERS                        ==
  -- ======================================================
  --[[
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = {
      "null_ls",
      "cmp",
      "nvim-lua/plenary.nvim"
    },
		config = function()
			configure("crates")
		end,
	},
  --]]
  {
    "b0o/SchemaStore.nvim",
  },
  {
    "karb94/neoscroll.nvim",
    -- event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "K",
        function()
          require("neoscroll").scroll(-vim.wo.scroll, true, 220)
        end,
        desc = "Scroll Up",
      },
      {
        "J",
        function()
          require("neoscroll").scroll(vim.wo.scroll, true, 220)
        end,
        desc = "Scroll Down",
      },
    },
    opts = { mappings = {} },
    config = function(_, opts)
      require("neoscroll").setup(opts)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-navic" },
    opts = function()
      local components = require("tukivim.plugins.lualine.theme").components
      local statusline = {
        lualine_a = { components.mode },
        lualine_b = {},
        lualine_c = { components.File.name, components.GIT.branch, components.GIT.diff },

        lualine_x = {
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
        options = {
          icons_enabled = true,
          theme = require("tukivim.plugins.lualine.theme").theme,
          always_divide_middle = true,
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "alpha" },
            winbar = { "alpha", "NvimTree" },
          },
        },
        sections = statusline,
        winbar = winbar,
        inactive_winbar = winbar,
      }
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Open file [e]xplorer" } },
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

        -- custom mappings
        vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
      end,

      update_focused_file = { enable = true },

      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = 45,
        hide_root_folder = false,
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
          symlink_arrow = " ➛ ",
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
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
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
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Go to next buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Go to prev buffer" },
    },
    opts = function()
      local icons = require("tukivim.com.res.icons").bufferline
      local custom_hl = require("tukivim.plugins.colorschemes.catppuccin.bufferline").get()
      return {
        highlights = custom_hl,
        options = {
          -- stylua: ignore
          close_command = function(n) require("mini.bufremove").delete(n, false) end,
          -- stylua: ignore
          left_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,

          -- icons
          indicator = { icon = icons.indicator_icon },
          buffer_close_icon = icons.buffer_close_icon,
          modified_icon = icons.modified_icon,
          close_icon = icons.close_icon,
          left_trunc_marker = icons.left_trunc_marker,
          right_trunc_marker = icons.right_trunc_marker,

          offsets = { { filetype = "NvimTree", text = "    ", text_align = "center" } },
          separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
          enforce_regular_tabs = true,
          always_show_bufferline = false,
          hover = { delay = 100 },
        },
      }
    end,
  },
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = { "<leader>c", "<leader>C" },
    config = function()
      require("mini.bufremove").setup()
      -- vim.keymap.set("n", "<leader>c", function() require("mini.bufremove").delete(0, false) end, { desc = "Delete Buffer" })
      -- vim.keymap.set("n", "<leader>C", function() require("mini.bufremove").delete(0, true) end, { desc = "Delete Buffer (Force)" })
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>lt", "<cmd>TodoTrouble<cr>",                           desc = "Todo (Trouble)" },
      { "<leader>lT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",   desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                         desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "▏", -- ▏ or │ or ▎
      show_current_context = true,
      show_current_context_start = false,
      filetype_exclude = {
        "help",
        "dashboard",
        "alpha",
        "Trouble",
        "text",
        "markdown",
      },
    },
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "css", "json", "jsonx", "html", "xml", "xaml" },
    config = function()
      require("colorizer").setup({ "*" }, { mode = "background" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map("n", "<leader>gj", gs.next_hunk, "Next Hunk")
        map("n", "<leader>gk", gs.prev_hunk, "Prev Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gl", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      end,
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local db = require("alpha.themes.dashboard")

      db.section.header.val = require("tukivim.com.res.acsii").pikachu_little

      db.section.buttons.val = {
        db.button("r", " " .. " Recent", "<cmd>Telescope oldfiles<cr>"),
        db.button("e", " " .. " New file", "<cmd>ene<cr>"),
        db.button("f", " " .. " Find file", "<cmd>cd $HOME/workspace | Telescope find_files<cr>"),
        db.button("s", " " .. " Restore Session", "<cmd>lua require('persistence').load()<cr>"),
        db.button("p", " " .. " Projects", "<cmd>cd $HOME/workspace | Telescope projects<cr>"),
        db.button("c", " " .. " Configs", "<cmd>e $MYVIMRC | :cd %:p:h <cr>"),
        db.button("l", "󰒲 " .. " Lazy", "<cmd>Lazy<cr>"),
        db.button("q", " " .. " Quit NVIM", "<cmd>qa<cr>"),
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
        pattern = "TukiVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {
      open_fold_hl_timeout = 150,
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = { scrollU = "<C-u>", scrollD = "<C-d>" },
      },
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" ... %d  "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
    config = function(_, opts)
      -- vim.o.fillchars = [[eobd: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      -- vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ufo = require("ufo")
      ufo.setup(opts)
      --- [ keymaps ]
      vim.keymap.set("n", "zO", ufo.openAllFolds, { silent = true, remap = false })
      vim.keymap.set("n", "zI", ufo.closeAllFolds, { silent = true, remap = false })
      vim.keymap.set("n", "zj", ufo.goNextClosedFold, { silent = true, remap = false })
      vim.keymap.set("n", "zk", ufo.goPreviousClosedFold, { silent = true, remap = false })
      vim.keymap.set("n", "zl", ufo.peekFoldedLinesUnderCursor, { silent = true, remap = false })
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter" },
    keys = { { "]]", desc = "Next Reference" }, { "[[", desc = "Prev Reference" } },
    opts = { providers = { "lsp" }, delay = 200, under_cursor = true },
    config = function(_, opts)
      require("illuminate").configure(opts)
      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      utils.on_attach(function(client, buffer)
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
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "nui.nvim", "nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
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
    },
  },
  --[[
	{
		"gnikdroy/projections.nvim",
		config = function()
			import("projections", function(projections)
				projections.setup({})
			end)
		end,
	},
  --]]
  --#endregion

  --#region COLORSCHEMES    | uncomment ONE of them to use colorscheme
  -- ======================================================
  -- ==                COLORSCHEMES                      ==
  -- ======================================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    run = ":CatppuccinCompile",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      styles = {
        comments     = { "italic" },
        conditionals = { "italic", "bold" },
        loops        = { "bold" },
        functions    = { "italic" },
        types        = { "italic" },
        keywords     = {},
        strings      = {},
        variables    = {},
        numbers      = {},
        booleans     = {},
        properties   = {},
        operators    = {},
      },
      integrations = {
        native_lsp       = {
          enabled      = true,
          virtual_text = {
            errors      = { "bold" },
            warnings    = { "bold" },
            hints       = {},
            information = {},
          },
          underlines   = {
            errors      = { "undercurl" },
            warnings    = { "undercurl" },
            hints       = {},
            information = {},
          },
        },
        treesitter       = true,
        lsp_trouble      = true,
        mason            = true,
        cmp              = true,
        gitsigns         = true,
        telescope        = true,
        which_key        = true,
        markdown         = true,
        flash            = true,
        notify           = true,
        mini             = true,
        noice            = true,
        nvimtree         = { enabled = true, show_root = true, transparent_panel = false },
        dap              = { enabled = true, enable_ui = true },
        indent_blankline = { enabled = true },
        navic            = { enabled = true, custom_bg = "#000000" },
      },
      custom_highlights = function(cp)
        local indent       = require("catppuccin.utils.colors").darken(cp.surface0, 0.80, cp.base)
        local surface_half = require("catppuccin.utils.colors").darken(cp.surface0, 0.64, cp.base)
        local folded_bg    = require("catppuccin.utils.colors").darken(cp.blue, 0.12, cp.base)
        local debug_bg     = require("catppuccin.utils.colors").darken(cp.mauve, 0.22, cp.base)
        return {
          -- [ Neovim ]
          NormalFloat                = { bg = cp.crust },
          FloatBorder                = { fg = cp.crust, bg = cp.crust },
          Pmenu                      = { bg = cp.crust },
          PmenuSbar                  = { bg = cp.mantle },
          -- [ Telescope ]
          -- Normals
          TelescopeNormal            = { fg = cp.mantle, bg = cp.mantle },
          TelescopePromptNormal      = { fg = cp.text, bg = surface_half },
          TelescopeResultsNormal     = { bg = cp.mantle },
          TelescopePreviewNormal     = { bg = cp.mantle },
          -- Borders
          TelescopePromptBorder      = { fg = surface_half, bg = surface_half },
          TelescopeResultsBorder     = { fg = cp.mantle, bg = cp.mantle },
          TelescopePreviewBorder     = { fg = cp.mantle, bg = cp.mantle },
          -- Selection
          TelescopeSelection         = { bg = cp.surface0 },
          TelescopeSelectionCaret    = { fg = cp.surface0, bg = cp.surface0 },
          TelescopeMultiSelection    = { bg = cp.surface0 },
          -- Titles
          TelescopeTitle             = { fg = cp.mantle, bg = cp.mantle },
          TelescopePromptTitle       = { fg = cp.base, bg = cp.mauve, style = { "bold" } },
          -- TelescopePreviewTitle = { fg = cp.red, bg = cp.crust },
          -- TelescopeResultsTitle = { fg = cp.mantle, bg = cp.mantle },
          -- Others
          TelescopePromptPrefix      = { fg = cp.mauve, bg = surface_half },
          TelescopeMatching          = { fg = cp.peach },
          TelescopePromptCounter     = { fg = cp.surface2, bg = surface_half },
          -- [ IndentBlankline ]
          IndentBlanklineChar        = { fg = indent },
          IndentBlanklineContextChar = { fg = cp.surface2 },
          -- [ Fold Preview ]
          Folded                     = { bg = folded_bg },
          FoldPreview                = { bg = folded_bg },
          FoldPreviewBorder          = { fg = folded_bg, bg = folded_bg },
          -- [ Illuminate ]
          IlluminatedWordText        = { bg = cp.surface0 },
          IlluminatedWordRead        = { bg = cp.surface0 },
          IlluminatedWordWrite       = { bg = cp.surface0 },
          -- [ Trouble ]
          TroubleNormal              = { bg = cp.crust },
          -- [ Syntax ]
          debugPC                    = { bg = debug_bg },
          -- [ StatusLine ]
          StatusLine                 = { fg = cp.base, bg = cp.base },
          StatusLineTerm             = { fg = cp.base, bg = cp.base },
          -- [ Winbar ]
          WinBar                     = { fg = cp.subtext0, bg = cp.base, style = { "bold" } },
          WinBarNC                   = { fg = cp.subtext0, bg = cp.base, style = { "bold" } },
          NavicText                  = { fg = cp.subtext0, style = { "italic" } },
          NavicSeparator             = { fg = cp.subtext1 },
          LspInlayHint               = { fg = cp.surface1, bg = cp.base, style = { "italic" } },
          -- [ GitSigns ]
          GitSignsAdd                = { fg = cp.subtext1 },
          GitSignsChange             = { fg = cp.surface2 },
          GitSignsDelete             = { fg = cp.red },
          -- [ Flash ]
          -- FlashBackdrop              = {fg = , bg = },
          FlashMatch                 = { fg = cp.lavender, bg = surface_half },
          FlashCurrent               = { fg = cp.text, bg = surface_half },
          FlashLabel                 = { fg = cp.base, bg = cp.subtext1 },
          -- [ Alpha ]
          AlphaHeader                = { fg = cp.yellow },
          AlphaFooter                = { fg = cp.subtext0 },
          AlphaButtons               = { fg = cp.lavender },
          AlphaShortcut              = { fg = cp.pink },
        }
      end
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  --#endregion

  --#region MODULE LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    init = function()
      -- disable lsp watcher. Too slow on linux
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
        wf._watchfunc = function()
          return function() end
        end
      end
    end,
    opts = {
      inlay_hints = { enabled = true },
      virtual_text = true,
      signs = { active = signs },
      autoformat = true,
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      float = {
        focusable = false,
        style = "minimal",
        border = "single",
        source = "always",
        header = "",
        prefix = "",
      },
      capabilities = {},

      servers = require("tukivim.plugins.lsp.servers"),

      setup = {},
    },
    config = function(_, opts)
      -- require("tukivim.plugins.lsp.config").setup(opts)

      -- setup keymaps
      utils.on_attach(function(client, buffer)
        require("tukivim.plugins.lsp.handlers").defaults.on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("tukivim.plugins.lsp.handlers").defaults.on_attach(client, buffer)
        return ret
      end

      -- setup diagnostics
      local diag_signs = {
        { name = "DiagnosticSignError", text = vim.tukivim.res.icons.diagnostic.error },
        { name = "DiagnosticSignWarn",  text = vim.tukivim.res.icons.diagnostic.warning },
        { name = "DiagnosticSignHint",  text = vim.tukivim.res.icons.diagnostic.hint },
        { name = "DiagnosticSignInfo",  text = vim.tukivim.res.icons.diagnostic.info },
      }

      for _, sign in ipairs(diag_signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
      if opts.inlay_hints.enabled and inlay_hint then
        utils.on_attach(function(client, buffer)
          if client.supports_method('textDocument/inlayHint') then inlay_hint(buffer, true) end
        end)
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- setup `cmp-nvim-lsp` capabilities
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      -- setup configured servers
      local servers = opts.servers

      ---setup lsp using `cmp-nvim-lsp` capabilities
      ---@param server string name of language server protocol
      local server_setup = function(server)
        local server_opts = vim.tbl_deep_extend(
          "force",
          { capabilities = vim.deepcopy(capabilities) },
          servers[server] or {}
        )

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then return end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then return end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available thourgh mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            server_setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = ensure_installed,
          handlers = { server_setup },
        })
      end
    end,
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   name = "null_ls",
  -- },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = { "<leader>lm" },
    opts = {
      -- install_root_dir = "/home/tuki/.local/share/nvim/mason",
      ui = {
        icons = {
          package_installed = "✔ ",
          package_pending = " ",
          package_uninstalled = "",
        },
      },
    },
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   config = function()
  --     require("mason-lspconfig")
  --   end,
  -- },
  -- {
  -- 	"jay-babu/mason-null-ls.nvim",
  -- 	config = function()
  -- 		require("mason-null-ls")
  -- 	end,
  -- },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>lD", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document [D]iagnostic" },
      { "<leader>ld", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace [d]iagnostic" },
      { "<leader>lQ", "<cmd>Trouble quickfix<cr>",                    desc = "Trouble [Q]uickfix" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
    opts = {
      use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
      action_keys = {
        jump = { "<cr>", "l" },    -- jump to the diagnostic or open / close folds
        jump_close = { "<tab>" },  -- jump to the diagnostic or open / close folds
        hover = "o",               -- opens a small popup with the full multiline message
        preview = { "p" },         -- preview the diagnostic location
        toggle_fold = { "zz" },    -- toggle fold of current file
      },
    },
  },
  --[[
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = { "dap" },
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		dependencies = { "dap" },
		config = function()
			configure("rust-tools")
		end,
	},
	{
		"jose-elias-alvarez/typescript.nvim",
		name = "typescript",
		-- ft = "typescript",
	},
  --]]
  --#endregion

  --#endregion MODULE LSP

  --#region MODULE CODING
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    build = ":TSUpdate",
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSInstallInfo",
      "TSInstallSync",
      "TSInstallFromGrammar",
    },
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true },
      context_commentstring = {
        enable = true,
      },
      ensure_installed = {
        "bash",
        "vim",
        "c",
        "cpp",
        "lua",
        "python",
        "java",
        "yaml",
        "html",
        "css",
        "json",
        "jsonc",
        "json5",
        "sql",
        "dockerfile",
        "toml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  --#region CMP             | completion manager and snippets
  -- ======================================================
  -- ==                     CMP                          ==
  -- ======================================================
  {
    "hrsh7th/nvim-cmp",
    name = "cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      { "hrsh7th/cmp-cmdline", keys = { ":", "/" } },
      "saadparwaiz1/cmp_luasnip",
      -- "lukas-reineke/cmp-under-comparator",
      -- "lukas-reineke/cmp-rg",
      -- "hrsh7th/cmp-nvim-lua",
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      -- "tzachar/cmp-tabnine",
    },

    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require("cmp")
      local kind_icons = vim.tukivim.res.icons.cmp

      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          -- ["<C-K>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          -- ["<C-J>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = function()
            if cmp.visible() then
              return cmp.mapping(cmp.close(), { "i", "c" })
            else
              return cmp.mapping(cmp.complete(), { "i", "c" })
            end
          end,
          ["<C-c>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        formatting = {
          fields = { "abbr", "kind" },
          format = function(_, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            return vim_item
          end,
        },
        sources = {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          -- { name = "nvim_lua" },
          { name = "buffer" },
          -- { name = "rg" },
          { name = "path" },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
        },
        view = {
          -- entries = { name = "custom", selection_order = "near_cursor" },
        },
        experimental = {
          ghost_text = { hl_group = "CmpGhostText" },
          native_menu = false,
        },
      }
    end,

    config = function(_, opts)
      local cmp = require("cmp")

      local default_mapping_cmdline = cmp.mapping.preset.insert({
        ["<C-j>"] = { c = function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end },
        ["<C-k>"] = { c = function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end },
        ["<C-c>"] = { c = cmp.mapping.close() },
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", { mapping = default_mapping_cmdline, sources = { { name = "buffer" } } })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = default_mapping_cmdline,
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })

      cmp.setup(opts)
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    keys = {
      {
        "<tab>",
        function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },

  --#endregion
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
      highlight = {
        ui = "DiagnosticSignWarn",
        search = "DiagnosticSignError",
        replace = "DiagnosticSignHint",
      },
    },
    keys = {
      {
        "<leader>SS",
        function()
          require("spectre").toggle()
        end,
        desc = "Spectre Toggle",
      },
      {
        "<leader>Sw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "S&R current word",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete surrounding" },
        { opts.mappings.find,           desc = "Find right surrounding" },
        { opts.mappings.find_left,      desc = "Find left surrounding" },
        { opts.mappings.highlight,      desc = "Highlight surrounding" },
        { opts.mappings.replace,        desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "sa",            -- Add surrounding in Normal and Visual modes
        delete = "sd",         -- Delete surrounding
        find = "sf",           -- Find surrounding (to the right)
        find_left = "sF",      -- Find surrounding (to the left)
        highlight = "sh",      -- Highlight surrounding
        replace = "sr",        -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "numToStr/Comment.nvim",
    keys = function()
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      return {
        {
          "<leader>/",
          function()
            require("Comment.api").toggle.linewise.current()
          end,
          desc = "Comment",
        },
        {
          "<leader>?",
          function()
            require("Comment.api").toggle.blockwise.current()
          end,
          desc = "Comment Blockwise",
        },
        {
          mode = "x",
          "<leader>/",
          function()
            vim.api.nvim_feedkeys(esc, "nx", false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
          end,
          desc = "Comment",
        },
        {
          mode = "x",
          "<leader>?",
          function()
            vim.api.nvim_feedkeys(esc, "nx", false)
            require("Comment.api").toggle.blockwise(vim.fn.visualmode())
          end,
          desc = "Comment Blockwise",
        },
      }
    end,
    opts = {
      padding = true,
      mappings = {
        basic = false,
        extra = false,
        extended = false,
      },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = { { "<leader>z", "<cmd>TSJToggle<cr>", desc = "Split-Join Toogle" } },
    opts = { use_default_keymaps = false, check_syntax_error = true, max_join_length = 150 },
  },

  --#endregion MODULE CODING

  --#region MODULE TOOLS

  --#region TELESCOPE       | blazing fast fuzzy finder
  -- ======================================================
  -- ==                   TELESCOPE                      ==
  -- ======================================================
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = { "telescope-fzf-native", "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>sc", "<cmd>[C]olorscheme<cr>",                  desc = "Colorscheme" },
      { "<leader>sg", require("telescope.builtin").git_branches, desc = "checkout [G]it branches" },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files({
            previewer = false,
            hidden = true,
            layout_config = { width = 0.5, height = 16 },
          })
        end,
        desc = "search [F]ile",
      },
      { "<leader>sF", require("telescope.builtin").find_files, desc = "search [F]ile Preview" },
      { "<leader>ss", require("telescope.builtin").live_grep,  desc = "search [S]ymbols" },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").live_grep({ hidden = true })
        end,
        desc = "search [S]ymbols (hidden)",
      },
      { "<leader>sh", require("telescope.builtin").help_tags, desc = "search [H]elp" },
      { "<leader>sb", require("telescope.builtin").buffers,   desc = "search [B]uffers" },
      { "<leader>sr", require("telescope.builtin").oldfiles,  desc = "search [R]ecent File" },
      { "<leader>sR", require("telescope.builtin").registers, desc = "search [R]egisters" },
      { "<leader>sk", require("telescope.builtin").keymaps,   desc = "search [K]eymaps" },
      { "<leader>sC", require("telescope.builtin").commands,  desc = "search [C]ommands" },
      {
        "<leader>sp",
        function()
          require("telescope").extensions.projects.projects()
        end,
        desc = "[p]rojects",
      },
    },

    opts = {
      defaults = {
        prompt_prefix = vim.tukivim.res.icons.telescope.prompt_prefix_s,
        selection_caret = vim.tukivim.res.icons.telescope.selection_caret,
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },

        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,

            ["<CR>"] = require("telescope.actions").select_default,
            ["<C-x>"] = require("telescope.actions").select_horizontal,
            ["<C-v>"] = require("telescope.actions").select_vertical,
            ["<C-t>"] = require("telescope.actions").select_tab,
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,

            ["<Tab>"] = require("telescope.actions").toggle_selection
                + require("telescope.actions").move_selection_worse,
            ["<S-Tab>"] = require("telescope.actions").toggle_selection
                + require("telescope.actions").move_selection_better,

            ["<C-l>"] = require("telescope.actions").complete_tag,
            ["<C-_>"] = require("telescope.actions").which_key, -- keys from pressing <C-/>
          },

          n = {
            ["<esc>"] = require("telescope.actions").close,
            ["<CR>"] = require("telescope.actions").select_default,
            ["<C-x>"] = require("telescope.actions").select_horizontal,
            ["<C-v>"] = require("telescope.actions").select_vertical,
            ["<C-t>"] = require("telescope.actions").select_tab,
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,

            ["j"] = require("telescope.actions").move_selection_next,
            ["k"] = require("telescope.actions").move_selection_previous,
            ["H"] = require("telescope.actions").move_to_top,
            ["M"] = require("telescope.actions").move_to_middle,
            ["L"] = require("telescope.actions").move_to_bottom,

            ["gg"] = require("telescope.actions").move_to_top,
            ["G"] = require("telescope.actions").move_to_bottom,

            ["?"] = require("telescope.actions").which_key,
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("notify")
      require("telescope").load_extension("projects")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    name = "telescope-fzf-native",
    lazy = true,
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release "
        .. "&& cmake --build build --config Release && cmake --install build --prefix build",
    config = function()
      require("telescope").setup({
        extensions = {
          ["fzf"] = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case", -- "ignore_case" | "respect_case"
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "telescope.nvim" },
    keys = {
      {
        "<leader>dc",
        function()
          require("telescope").extensions.dap.commands({ layout_config = { width = 0.4, height = 16 } })
        end,
        desc = "dap [C]ommands",
      },
      {
        "<leader>db",
        function()
          require("telescope").extensions.dap.list_breakpoints()
        end,
        desc = "dap [B]reapoints",
      },
    },

    config = function()
      require("telescope").load_extension("dap")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "telescope.nvim" },
    eys = { { "<leader>sm", "<cmd>Telescope harpoon marks<cr>", desc = "search [M]arks" } },
    opts = {
      global_settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,
      },
    },
  },
  --#endregion

  --#region DAP             | debug adapter protocol
  -- ======================================================
  -- ==             DEBUG ADAPTER PROTOCOL               ==
  -- ======================================================
  {
    "mfussenegger/nvim-dap",
    name = "dap",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        keys = {},
        opts = {
          enabled = true,                     -- enable this plugin (the default)
          enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = true,    -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true,            -- show stop reason when stopped for exceptions
          commented = false,                  -- prefix virtual text with comment string
          virt_text_pos = "inline",           -- position of virtual text, see `:h nvim_buf_set_extmark()`

          -- experimental features:
          all_frames = false,      -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          virt_lines = false,      -- show virtual lines instead of virtual text (will flicker!)
          virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        },
      },
      {
        "rcarriga/nvim-dap-ui",
        commit = "f2206de65ea39093e3f13992507fc985c17aa763", -- BUG: up-to-date is broken for `Java` language
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle()
            end,
            desc = "dap Toogle [U]I",
          },
        },
        opts = {
          layouts = {
            {
              elements = { { id = "stacks", size = 0.5 }, { id = "watches", size = 0.5 } },
              position = "left",
              size = 40,
            },
            {
              elements = { { id = "repl", size = 0.5 }, { id = "console", size = 0.5 } },
              position = "bottom",
              size = 0.3,
            },
          },
        },
        config = function(_, opts)
          require("dapui").setup(opts)
        end,
      },
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("/opt/miniconda3/bin/python")
        end,
      },
    },
    keys = {
      {
        "<leader>dd",
        function()
          require("dap").continue()
        end,
        desc = "[d]ebug",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "dap Run [l]ast",
      },
      {
        "<F1>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "DAP Continue",
      },
      -- { "<F2>", function() require("dap").terminate() end, desc = "DAP Terminate" },
      -- { "<F10>", function() require("dap").step_over() end, desc = "DAP Step Over" },
      -- { "<F11>", function() require("dap").step_into() end, desc = "DAP Step Into" },
      -- { "<F12>", function() require("dap").step_out() end, desc = "DAP Step Out" },
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", {
        text = "●",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = "●",
        texthl = "DapBreakpointCondition",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapLogPoint", {
        text = "◆",
        texthl = "DapLogPoint",
        linehl = "",
        numhl = "",
      })
    end,
  },
  --#endregion

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    keys = {
      {
        "<leader>vss",
        function()
          require("persistence").load()
        end,
        desc = "Restore [s]ession",
      },
      {
        "<leader>vsl",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore [l]ast Session",
      },
      {
        "<leader>vsd",
        function()
          require("persistence").stop()
        end,
        desc = "[d]elete Current Session",
      },
    },
  },

  --#region OTHERS
  -- ======================================================
  -- ==                    OTHERS                        ==
  -- ======================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = {
        marks = true,     -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false,                             -- adds help for operators like d, y, ...
          motions = false,                               -- adds help for motions
          text_objects = false,                          -- help for text objects triggered after entering an operator
          windows = true,                                -- default bindings on <c-w>
          nav = true,                                    -- misc bindings to work with windows
          z = true,                                      -- bindings for folds, spelling and others prefixed with z
          g = true,                                      -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
      },
      icons = vim.tukivim.res.icons.wk,
      window = {
        border = "none",          -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 4,                    -- spacing between columns
        align = "left",
      },
      show_help = false,
      show_keys = false,
    },

    config = function(_, opts)
      require("which-key").setup(opts)
      vim.tukivim.setup_keymaps()
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      stages = "fade",    -- Animation style (see below for details)
      render = "default", -- Render function for notifications. See notify-render()
      timeout = 3000,     -- Default timeout for notifications
      on_open = nil,      -- Function called when a new window is opened, use for changing win settings/config
      on_close = nil,     -- Function called when a window is closed
      max_width = nil,
      max_height = nil,
      minimum_width = 42,
      icons = vim.tukivim.res.icons.notify,
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      multi_window = false,
      modes = {
        -- a regular search with `/` or `?`
        search = {
          enabled = true,
          highlight = { backdrop = false },
          jump = { history = true, register = true, nohlsearch = true },
          search = {
            -- `forward` will be automatically set to the search direction
            -- `mode` is always set to `search`
            -- `incremental` is set to `true` when `incsearch` is enabled
          },
        },
        char = {
          enabled = true,
          label = { exclude = "hjkliardc" },
          keys = { "f", "F", "t", "T", ";", "," },
          char_actions = function(motion)
            return {
              [";"] = "next",
              [","] = "prev",

              -- clever-f style
              [motion:lower()] = "next",
              [motion:upper()] = "prev",
            }
          end,
        },
        treesitter = {
          jump = { pos = "range" },
          search = { incremental = false },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
        treesitter_search = {
          jump = { pos = "range" },
          search = {
            multi_window = false,
            wrap = true,
            incremental = false,
          },
        },
        -- options used for remote flash
        remote = {
          remote_op = { restore = true, motion = true },
        },
      },
    },
    keys = function()
      local flash = require("flash")
      local label_format = function(opts)
        return {
          { opts.match.label1, "FlashMatch" },
          { opts.match.label2, "FlashLabel" },
        }
      end

      return {
        {
          "sw",
          mode = { "n", "x", "o" },
          desc = "Flash [w]ord",
          function()
            flash.jump({
              search = { mode = "search" },
              label = { after = false, before = { 0, 0 }, uppercase = false, format = label_format },
              pattern = [[\<]],
              action = function(match, state)
                state:hide()
                flash.jump({
                  search = { max_length = 0 },
                  highlight = { matches = false },
                  label = { format = label_format },
                  matcher = function(win)
                    -- limit matches to the current label
                    return vim.tbl_filter(function(m)
                      return m.label == match.label and m.win == win
                    end, state.results)
                  end,
                  labeler = function(matches)
                    for _, m in ipairs(matches) do
                      m.label = m.label2 -- use the second label
                    end
                  end,
                })
              end,
              labeler = function(matches, state)
                local labels = state:labels()
                for m, match in ipairs(matches) do
                  match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                  match.label2 = labels[(m - 1) % #labels + 1]
                  match.label = match.label1
                end
              end,
            })
          end,
        },
        {
          "sl",
          mode = { "n", "x", "o" },
          desc = "Flash [l]ine",
          function()
            flash.jump({
              pattern = "^",
              search = { mode = "search", max_length = 0 },
              label = { after = { 0, 0 } },
            })
          end,
        },
        { "ss",    mode = { "n", "x", "o" }, function() flash.jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "o", "x" }, function() flash.treesitter() end,        desc = "Flash TS" },
        { "r",     mode = { "o" },           function() flash.remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() flash.treesitter_search() end, desc = "TS Search" },
        { "<c-f>", mode = { "c" },           function() flash.toggle() end,            desc = "Toggle Search" },
      }
    end,
  },
  {
    "nvim-focus/focus.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = { { "<C-s><C-f>", "<cmd>FocusToggle<cr>", desc = "Toggle [f]ocus mode" } },
    opts = {
      enable = true,
      commands = true,
      autoresize = { enable = true },
      ui = {
        number = false,                    -- Display line numbers in the focussed window only
        relativenumber = false,            -- Display relative line numbers in the focussed window only
        hybridnumber = false,              -- Display hybrid line numbers in the focussed window only
        absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

        cursorline = true,                 -- Display a cursorline in the focussed window only
        cursorcolumn = false,              -- Display cursorcolumn in the focussed window only
        colorcolumn = {
          enable = false,                  -- Display colorcolumn in the foccused window only
          list = "+1",                     -- Set the comma-saperated list for the colorcolumn
        },
        signcolumn = false,                -- Display signcolumn in the focussed window only
        winhighlight = false,              -- Auto highlighting for focussed/unfocussed windows
      },
    },
    config = function(_, opts)
      require("focus").setup(opts)

      -- Disabling `Focus` for filetypes
      local ignore_filetypes = { "neo-tree", "NvimTree", "toggleterm" }
      local ignore_buftypes = { "nofile", "prompt", "popup" }

      local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

      vim.api.nvim_create_autocmd("WinEnter", {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.b.focus_disable = true
          end
        end,
        desc = "Disable focus autoresize for BufType",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
          end
        end,
        desc = "Disable focus autoresize for FileType",
      })
    end,
  },
  --#endregion

  --#endregion
}

-- Setup with config
lazy.setup(PLUGINS, {
  defaults = { lazy = false },
  dev = {
    path = "~/workspace/dev",
    patterns = { "tuki", "TukiVim" },
  },
  install = {
    missing = true,
    colorscheme = { "catppuccin" },
  },
  checker = { enabled = true },
  diff = { cmd = "git" },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    border = "none",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
})
