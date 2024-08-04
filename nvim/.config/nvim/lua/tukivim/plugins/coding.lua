local ICONS = require("tukivim.c.res.icons")
local KEYMAPS = require("tukivim.c.keymaps")

return {
  {
    "nvim-treesitter/nvim-treesitter",
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
      highlight = { enable = true },
      autotag = { enable = true },
      indent = { enable = true },
      -- context_commentstring = { enable = true },
      ensure_installed = {
        "bash",
        "vim",
        "c",
        "cpp",
        "lua",
        "python",
        "java",
        "html",
        "css",
        "json",
        "jsonc",
        "json5",
        "sql",
        "dockerfile",
        "toml",
        "javascript",
        "typescript",
        "tsx",
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
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact"
    },
    opts = {},
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      { "hrsh7th/cmp-cmdline", keys = { ":", "/" } },
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      -- "lukas-reineke/cmp-under-comparator",
      -- "lukas-reineke/cmp-rg",
      -- "hrsh7th/cmp-nvim-lua",
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      -- "tzachar/cmp-tabnine",
    },

    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require("cmp")
      local kind_icons = ICONS.cmp
      local compare = require("cmp.config.compare")
      local lspkind = require('lspkind')
      local defaults = require("cmp.config.default")()

      return {
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
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
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
              symbol_map = kind_icons,
              mode = "symbol_text",
              maxwidth = 50,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            -- kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind

            -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            -- return vim_item
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
        sorting = defaults.sorting,
        -- sorting = {
        --   priority_weight = 2,
        --   comparators = {
        --     compare.exact,
        --     compare.score,
        --     compare.recently_used,
        --     compare.offset,
        --     compare.kind,
        --     compare.sort_text,
        --     compare.length,
        --     compare.order,
        --   },
        -- },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = {
            col_offset = -3,
            side_padding = 0,
          },
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            max_width = 50,
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
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    keys = KEYMAPS.keys("flash"),
    opts = {
      multi_window = false,
      modes = {
        -- a regular search with `/` or `?`
        search = {
          enabled = false,
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
          highlight = { backdrop = false, matches = false },
        },
        treesitter_search = {
          jump = { pos = "range" },
          search = { multi_window = false, wrap = true, incremental = false },
        },
        -- options used for remote flash
        remote = {
          remote_op = { restore = true, motion = true },
        },
      },
    },
    config = function(_, opts)
      require("flash").setup(opts)
      KEYMAPS.load("flash")
    end
  },
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
    keys = KEYMAPS.keys("spectre"),
    config = function(_, opts)
      require("spectre").setup(opts)
      KEYMAPS.load("spectre")
    end
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
      mappings = vim.tbl_filter(
        function(m) return m[1] and #m[1] > 0 end,
        mappings
      )
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add            = "sa", -- Add surrounding in Normal and Visual modes
        delete         = "sd", -- Delete surrounding
        find           = "sf", -- Find surrounding (to the right)
        find_left      = "sF", -- Find surrounding (to the left)
        highlight      = "sh", -- Highlight surrounding
        replace        = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require("mini.ai").setup(opts) end,
  },
  {
    "numToStr/Comment.nvim",
    keys = KEYMAPS.keys("comment"),
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
      KEYMAPS.load("comment")
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = KEYMAPS.keys("treesj"),
    opts = { use_default_keymaps = false, check_syntax_error = true, max_join_length = 150 },
    config = function(_, opts)
      require("treesj").setup(opts)
      KEYMAPS.load("treesj")
    end,
  },
}
--#endregion MODULE CODING
