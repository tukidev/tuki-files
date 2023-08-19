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

local THEME = require("tukivim.plugins.colorschemes.catppuccin.lualine.mocha")

local M = {}

M.mode_color = THEME.mode_colors

M.theme = THEME.theme

M.components = {
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
				if not ok then
					return ""
				end

				local ok_location, navic_location = pcall(navic.get_location, {})
				if not ok_location then
					return ""
				end

				if not navic.is_available() or navic_location == "error" then
					return ""
				end

				if string.len(navic_location) < 1 then
					return ""
				end

				return "%#Winbar# %*" .. navic_location
			end,
		},

		diag_ok = {
			function()
				if #vim.diagnostic.get(0) > 0 then
					return ""
				end
				return "%#diffAdded# "
			end,
		},

		diag = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = "ﱢ ", warn = "卑", info = "● ", hint = " " },
			diagnostics_color = THEME.winbar.diagnostic,
		},
	},

	mode = {
		function()
			return "▎●"
		end,
		padding = { right = 1 },
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
					if buf_ft == "java" then
						return " jdtls.plugin"
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
			symbols = { error = "ﱢ ", warn = "卑", info = "● ", hint = " " },
			-- symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
			diagnostics_color = THEME.diagnostic,
		},
	},

	GIT = {
		branch = {
			"branch",
			icon = "",
		},
		diff = {
			"diff",
			symbols = { added = "+", modified = "~", removed = "" },
			diff_color = THEME.git,
			cond = conditions.hide_in_width,
		},
	},

	Carret = {
		location = {
			"location",
			icon = "",
		},
		percent = {
			"progress",
			icon = "",
			separator = { left = "" },
		},
	},
}

return M
