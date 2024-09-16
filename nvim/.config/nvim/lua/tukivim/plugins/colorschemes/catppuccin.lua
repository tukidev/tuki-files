return {
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
        navic            = { enabled = true },
      },
      custom_highlights = function(cp)
        local darken       = require("catppuccin.utils.colors").darken
        local darken_kind  = function(color) darken(color, 0.5, cp.crust) end
        local indent       = darken(cp.surface0, 0.80, cp.base)
        local surface_half = darken(cp.surface0, 0.64, cp.base)
        local folded_bg    = darken(cp.blue, 0.12, cp.base)
        local debug_bg     = darken(cp.mauve, 0.22, cp.base)
        return {
          -- [ Neovim ]
          NormalFloat             = { bg = cp.crust },
          FloatBorder             = { fg = cp.crust, bg = cp.crust },
          Pmenu                   = { bg = cp.crust },
          PmenuSbar               = { bg = cp.mantle },
          -- [ Telescope ]
          -- Normals
          TelescopeNormal         = { fg = cp.mantle, bg = cp.mantle },
          TelescopePromptNormal   = { fg = cp.text, bg = surface_half },
          TelescopeResultsNormal  = { bg = cp.mantle },
          TelescopePreviewNormal  = { bg = cp.mantle },
          -- Borders
          TelescopePromptBorder   = { fg = surface_half, bg = surface_half },
          TelescopeResultsBorder  = { fg = cp.mantle, bg = cp.mantle },
          TelescopePreviewBorder  = { fg = cp.mantle, bg = cp.mantle },
          -- Selection
          TelescopeSelection      = { bg = cp.surface0 },
          TelescopeSelectionCaret = { fg = cp.sapphire, bg = cp.surface0 },
          TelescopeMultiSelection = { bg = cp.surface0 },
          -- Titles
          TelescopeTitle          = { fg = cp.mantle, bg = cp.mantle },
          TelescopePromptTitle    = { fg = cp.base, bg = cp.sapphire, style = { "bold" } },
          -- TelescopePreviewTitle = { fg = cp.red, bg = cp.crust },
          -- TelescopeResultsTitle = { fg = cp.mantle, bg = cp.mantle },
          -- Others
          TelescopePromptPrefix   = { fg = cp.sapphire, bg = surface_half },
          TelescopeMatching       = { fg = cp.peach },
          TelescopePromptCounter  = { fg = cp.surface2, bg = surface_half },
          -- [ IndentBlankline ]
          IblIndent               = { fg = indent },
          IblScope                = { fg = cp.surface2 },
          -- [ Fold Preview ]
          Folded                  = { bg = folded_bg },
          FoldPreview             = { bg = folded_bg },
          FoldPreviewBorder       = { fg = folded_bg, bg = folded_bg },
          -- [ Illuminate ]
          IlluminatedWordText     = { bg = cp.surface0 },
          IlluminatedWordRead     = { bg = cp.surface0 },
          IlluminatedWordWrite    = { bg = cp.surface0 },
          -- [ Trouble ]
          TroubleNormal           = { bg = cp.crust },
          -- [ Syntax ]
          debugPC                 = { bg = debug_bg },
          -- [ StatusLine ]
          StatusLine              = { fg = cp.base, bg = cp.base },
          StatusLineTerm          = { fg = cp.base, bg = cp.base },
          -- [ Winbar ]
          WinBar                  = { fg = cp.subtext0, bg = cp.base, style = { "bold" } },
          WinBarNC                = { fg = cp.subtext0, bg = cp.base, style = { "bold" } },
          NavicText               = { fg = cp.subtext0, style = { "italic" } },
          NavicSeparator          = { fg = cp.subtext1 },
          LspInlayHint            = { fg = cp.surface1, bg = cp.base, style = { "italic" } },
          -- [ GitSigns ]
          GitSignsAdd             = { fg = cp.subtext1 },
          GitSignsChange          = { fg = cp.surface2 },
          GitSignsDelete          = { fg = cp.red },
          -- [ Flash ]
          -- FlashBackdrop              = {fg = , bg = },
          FlashMatch              = { fg = cp.lavender, bg = surface_half },
          FlashCurrent            = { fg = cp.text, bg = surface_half },
          FlashLabel              = { fg = cp.base, bg = cp.subtext1 },
          -- [ Alpha ]
          AlphaHeader             = { fg = cp.yellow },
          AlphaFooter             = { fg = cp.subtext0 },
          AlphaButtons            = { fg = cp.lavender },
          AlphaShortcut           = { fg = cp.pink },
        }
      end
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
