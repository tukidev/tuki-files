if not require("tukivim.c").pde["markdown"] then
  return {}
end

return {
  -- add yaml specific modules to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["marksman"] = {}
      },
    },
  },

  -- better view and concealling
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ft = "markdown",
    opts = {
      enabled = true,
      max_file_size = 10.0, -- in MB
      debounce = 100,       -- Milliseconds before updating marks
      preset = 'none',      -- 'obsidian' | 'lazy' | 'none'
      anti_conceal = { enabled = true },
      sign = { enabled = false },
      heading = {
        enabled = true,
        position = 'overlay', -- 'inline' | 'overlay'
        -- icons = { ' ', ' ', '󰨐 ', ' ', ' ', '󱓜 ' }, -- Replaces '#+' of 'atx_h._marker'
        icons = { '󰫎 ' },
        sign = false,
        signs = { '󰫎 ' }, -- Added to the sign column if enabled
        width = 'full', -- 'block' | 'full' | array
        left_pad = 0,
        right_pad = 0, -- if width == 'block'
        min_width = 0, -- if width == 'block'
      },
      bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
        left_pad = 0,
        right_pad = 0,
      },
      checkbox = {
        enabled = true,
        left_pad = 2,
        right_pad = 2,
        unchecked = { icon = ' ' },
        checked = { icon = ' ' },
        -- unchecked = { icon = '󰄱 ', highlight = 'RenderMarkdownUnchecked' },
        -- checked = { icon = '󰱒 ', highlight = 'RenderMarkdownChecked' },
        custom = {
          canceled = { raw = "[~]", rendered = "󰜺 ", highlight = "RenderMarkdownError" },
          important = { raw = '[!]', rendered = ' ', highlight = 'RenderMarkdownWarn' },
          todo = { raw = '[-]', rendered = ' ', highlight = 'RenderMarkdownTodo' },
        },
      },
      -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'
      -- Can specify as many additional values as you like following the pattern from any below, such as 'note'
      --   The key in this case 'note' is for healthcheck and to allow users to change its values
      --   'raw':       Matched against the raw text of a 'shortcut_link', case insensitive
      --   'rendered':  Replaces the 'raw' value when rendering
      --   'highlight': Highlight for the 'rendered' text and quote markers
      callout = {
        note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
        tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
        important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
        warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
        caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
        -- Obsidian: https://help.a.md/Editing+and+formatting/Callouts
        abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'RenderMarkdownInfo' },
        todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'RenderMarkdownInfo' },
        success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'RenderMarkdownSuccess' },
        question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'RenderMarkdownWarn' },
        failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'RenderMarkdownError' },
        danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'RenderMarkdownError' },
        bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'RenderMarkdownError' },
        example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'RenderMarkdownHint' },
        quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = 'RenderMarkdownQuote' },
      },
    },
  },

  -- catppuccin theme plugin
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { render_markdown = true } }
  }
}
