local KEYMAPS = require("tukivim.c.keymaps")

return {
  {
    "karb94/neoscroll.nvim",
    keys = { "K", "J" },
    opts = { mappings = {} },
    config = function(_, opts)
      require("neoscroll").setup(opts)
      KEYMAPS.load("neoscroll")
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    keys = KEYMAPS.keys("todo-comments"),
    opts = {
      signs = true,      -- show icons in the signs column
      sign_priority = 8, -- sign priority
      keywords = {
        FIX  = { icon = "", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = "", color = "info" },
        HACK = { icon = "", color = "warning" },
        WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰾆", alt = { "OPT", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "", color = "hint", alt = { "INFO", "HINT" } },
        TEST = { icon = "", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },

    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
      KEYMAPS.load("todo-comments")
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
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "▏",
        highlight = "IblIndent",
        smart_indent_cap = true,
      },
      scope = {
        enabled = true,
        char = "▏",
        highlight = "IblScope",
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "alpha",
          "Trouble",
          "text",
          "markdown",
        },
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = { -- ▌ ▍ ▎ ▎ ▎ ▶ 
        add = { text = "▍" },
        change = { text = "▍" },
        delete = { text = "▶" },
        topdelete = { text = "▶" },
        changedelete = { text = "▍" },
        untracked = { text = "▍" },
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
        local suffix = (" ... %d  "):format(endLnum - lnum)
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

      require("ufo").setup(opts)
      KEYMAPS.load("ufo")
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
    "nvim-focus/focus.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = KEYMAPS.keys("focus"),
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
      KEYMAPS.load("focus")

      -- Disabling `Focus` for filetypes
      local ignore_filetypes = {
        "neo-tree",
        "NvimTree",
        "nvimtree",
        "toggleterm",
        "dressinginput",
      }
      local ignore_buftypes = { "nofile", "prompt", "popup" }

      local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

      vim.api.nvim_create_autocmd('WinEnter', {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.w.focus_disable = true
          else
            vim.w.focus_disable = false
          end
        end,
        desc = 'Disable focus autoresize for BufType',
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.w.focus_disable = true
          else
            vim.w.focus_disable = false
          end
        end,
        desc = 'Disable focus autoresize for FileType',
      })
    end,
  },
}
