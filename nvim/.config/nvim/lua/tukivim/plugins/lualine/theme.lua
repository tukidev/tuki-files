-- Separator's symbols
-- "┃", "█", "", "", "", "", "", "", "●"

-- Utils
local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,

	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,

	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local theme = require("tukivim.plugins.colorschemes.catppuccin.lualine.mocha")

local M = {}

M.mode_color = theme.mode_colors

local hl_line = { bg = theme.line_bg, fg = theme.line_fg }

M.theme = {
	normal = { a = hl_line, b = hl_line, c = hl_line },
	insert = { a = hl_line, b = hl_line, c = hl_line },
	visual = { a = hl_line, b = hl_line, c = hl_line },
	replace = { a = hl_line, b = hl_line, c = hl_line },
}

M.components = {
	mode = {
		function()
			return "██"
		end,
		padding = { right = 1 },
		color = function()
			return { fg = M.mode_color[vim.fn.mode()] }
		end,
	},

	File = {
		name = {
			"filename",
			icon = "",
			cond = conditions.buffer_not_empty,
			padding = { left = 2, right = 1 },
		},
		type = {
			"filetype",
			fmt = string.upper,
		},
	},

	LSP = {
		name = {
			function()
				local msg = " none"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return " none"
				end
				for _, client in ipairs(clients) do
          -- defining plugin `nvim-jdtls`
          if buf_ft == "java" and vim.g.jdtls_on then
            return " jdt.ls.plugin"
          end
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return " " .. client.name
					end
				end
				return msg
			end,
			icon = false,
			padding = { left = 2, right = 1 },
		},
		diag = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			diagnostics_color = theme.diagnostic,
		},
	},

	GIT = {
		branch = {
			"branch",
			icon = "",
		},
		diff = {
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = { added = " ", modified = " ", removed = " " },
			diff_color = theme.git,
			cond = conditions.hide_in_width,
		},
	},

	Carret = {
		location = {
			"location",
			icon = "",
			color = function()
				return { bg = M.mode_color[vim.fn.mode()] }
			end,
		},
		percent = {
			"progress",
			separator = { left = "" },
			color = function()
				return { bg = M.mode_color[vim.fn.mode()] }
			end,
		},
	},
}

-- used just 2 sections
-- lualine_c for the right side
-- lualine_x for the left side
M.sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_y = {},
	lualine_z = {},

	lualine_c = {
		M.components.mode,
		M.components.File.type,
		M.components.File.name,
		M.components.LSP.name,
		M.components.LSP.diag,
	},

	lualine_x = {
		M.components.GIT.diff,
		M.components.GIT.branch,
		M.components.Carret.percent,
		M.components.Carret.location,
	},
}


return M
