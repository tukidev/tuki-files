local UTILS = require("tukivim.c.utils")

local cp = require("catppuccin.palettes").get_palette()
-- Separator's symbols
-- "┃", "█", "", "", "", "", "", "", "●"

-- Utils
local mode_label = {
  n       = "normal",
  no      = 'op',
  nov     = 'op',
  noV     = 'op',
  ["no"] = 'op',
  v       = "visual",
  V       = "v-line",
  [""]   = "v-block",
  i       = "insert",
  R       = "replace",
  c       = "command",
  t       = "terminal",
}

-- local lsp_colors = {
--   ["lua_ls"] = cp.lavender,
--   ["jdtls"] = cp.peach,
--   ["pyright"] = cp.sky,
--   ["ruff_lsp"] = cp.peach,
-- }

local conditions = {
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,

  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local THEME = require("tukivim.plugins.utils.colorschemes.catppuccin.lualine")

local M = {}

M.mode_color = THEME.mode_colors

M.theme = THEME.theme

M.components = {
  python_environment = {
    function()
      local venv_name = require("venv-selector").get_active_venv()
      if venv_name == nil then
        return ""
      end
      return string.gsub(venv_name, ".*/anaconda3/envs/", "(conda) ")
    end,
    cond = function()
      vim.print(UTILS.has("venv-selector.nvim"))
      return vim.bo.filetype == "python" and UTILS.has("venv-selector.nvim")
    end,
    icon = "",
    color = { fg = cp.green }
  },
  winbar = {
    file = {
      function()
        local filename = vim.fn.expand("%:t")
        local extension = vim.fn.expand("%:e")

        local file_icon, file_icon_color = require("nvim-web-devicons").get_icon_color(
          filename,
          extension,
          { default = true }
        )

        local hl_group = "FileIconColor" .. extension

        vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })

        return "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " %#WinBar#" .. filename .. "%*"
      end,
    },

    navic = {
      function()
        local ok, navic = pcall(require, "nvim-navic")
        if not ok then return "" end

        local ok_location, navic_location = pcall(navic.get_location, {})
        if not ok_location then return "" end

        if not navic.is_available() or navic_location == "error" then return "" end

        if string.len(navic_location) < 1 then return "" end

        return "%#Winbar# %*" .. navic_location
      end,
    },

    diag_ok = {
      function()
        if #vim.diagnostic.get(0) > 0 then
          return ""
        end
        return " "
      end,
    },

    diag = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = "󰔶 ", info = "● ", hint = "󰌵 " },
      diagnostics_color = THEME.winbar.diagnostic,
    },
  },

  mode_label = {
    function()
      local mode = vim.fn.mode()
      if mode == "n" then return "" end
      return mode_label[mode]
    end,
    fmt = string.upper,
    padding = 0,
    separator = { right = "" },
  },
  mode_indicator = {
    function()
      local mode = vim.fn.mode()
      local buf = vim.api.nvim_win_get_buf(0)

      local sign = ""
      if mode == "n" then
        sign = ""
      end

      if (vim.bo[buf].readonly or not vim.bo[buf].modifiable) then
        sign = ""
      end

      if mode == "t" then
        sign = ""
      end

      -- if mode == "n" then return "" end
      return sign .. " "
    end,
    padding = 0,
    separator = { left = "" },
    color = function()
      if vim.fn.mode() == 't' then
        return { fg = cp.base }
      end
      if (vim.bo.readonly or not vim.bo.modifiable) then
        return vim.fn.mode() == 'R' and { fg = cp.base } or { fg = cp.red }
      end
    end
  },

  mode = {
    function()
      local mode = vim.fn.mode()
      local buf = vim.api.nvim_win_get_buf(0)
      local sign = (vim.bo[buf].readonly or not vim.bo[buf].modifiable) and "" or ""
      if mode == "n" then return sign end
      return sign .. " " .. mode_label[mode]
    end,
    fmt = string.upper,
    padding = 0,
    separator = { left = "", right = "" },
  },

  File = {
    name = {
      "filename",
      cond = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
      icon = "󰈔",
      path = 1,
      symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '',         -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for newly created file before first write
      },
      padding = { left = 2, right = 1 },
    },
    type = {
      "filetype",
      padding = 1,
      icon_only = false, -- Display only an icon for filetype
      fmt = string.upper,
    },
  },

  LSP = {
    name = {
      function()
        local msg = ""
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })

        -- defining plugin `nvim-jdtls`
        -- if buf_ft == "java" then
        --   return "jdtls.plugin"
        -- end

        local client_names = {}
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            table.insert(client_names, client.name)
          end
        end
        msg = table.concat(client_names, ", ")

        return msg
      end,
      icon = " ",
      cond = function()
        local lsp = vim.lsp.get_active_clients({ bufnr = 0 })
        return next(lsp) ~= nil
      end,
      padding = { left = 2, right = 1 },
      color = { fg = cp.lavender }
    },
    diag = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
      -- symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
      diagnostics_color = THEME.diagnostic,
    },
  },

  GIT = {
    branch = {
      "branch",
      icon = "",
      color = { fg = cp.green },
    },
    diff = {
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
      diff_color = THEME.git,
      padding = { left = 0 },
      cond = conditions.hide_in_width,
    },
  },

  Carret = {
    location = {
      "location",
      icon = ":",
    },
    percent = {
      "progress",
      icon = "",
      separator = { left = "" },
    },
  },
}

return M
