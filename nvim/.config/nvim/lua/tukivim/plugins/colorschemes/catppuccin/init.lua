import("catppuccin", function(catppuccin)
	local cp = require("catppuccin.palettes").get_palette()
	local ucolors = require("catppuccin.utils.colors")
	local surface_half = ucolors.darken(cp.surface0, 0.64, cp.base)
	local indent = ucolors.darken(cp.surface0, 0.42, cp.base)
	local indent_context = ucolors.darken(cp.surface1, 0.42, cp.surface2)
	local folded_bg = ucolors.darken(cp.blue, 0.16, cp.base)
	local debug_bg = ucolors.darken(cp.mauve, 0.22, cp.base)

	catppuccin.setup({
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.50,
		},
		transparent_background = false,
		term_colors = false,
		compile = {
			enabled = true,
			path = vim.fn.stdpath("cache") .. "/catppuccin",
			suffix = "_compiled",
		},
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			loops = {},
			functions = { "italic" },
			keywords = { "bold" },
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		integrations = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "bold" },
					warnings = { "bold" },
					hints = {},
					information = {},
				},
				underlines = {
					errors = { "underline" },
					warnings = { "underline" },
					hints = {},
					information = {},
				},
			},
			coc_nvim = false,
			lsp_trouble = true,
			cmp = true,
			lsp_saga = false,
			gitgutter = false,
			gitsigns = true,
			telescope = true,
			nvimtree = {
				enabled = true,
				show_root = true,
				transparent_panel = false,
			},
			neotree = {
				enabled = false,
				show_root = true,
				transparent_panel = false,
			},
			dap = {
				enabled = true,
				enable_ui = true,
			},
			which_key = true,
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
			},
			dashboard = false,
			neogit = false,
			vim_sneak = false,
			fern = false,
			barbar = false,
			bufferline = true,
			markdown = true,
			lightspeed = false,
			ts_rainbow = false,
			hop = true,
			notify = true,
			telekasten = true,
			symbols_outline = false,
			mini = false,
		},

		custom_highlights = {
			-- [ Neovim ]
			NormalFloat = { bg = cp.surface0 },
			FloatBorder = { fg = cp.surface0, bg = cp.surface0 },

			-- [ Telescope ]
			-- Normals
			TelescopeNormal = { fg = cp.mantle, bg = cp.mantle },
			TelescopePromptNormal = { fg = cp.text, bg = surface_half },
			TelescopeResultsNormal = { bg = cp.mantle },
			TelescopePreviewNormal = { bg = cp.mantle },

			-- Borders
			TelescopePromptBorder = { fg = surface_half, bg = surface_half },
			TelescopeResultsBorder = { fg = cp.mantle, bg = cp.mantle },
			TelescopePreviewBorder = { fg = cp.mantle, bg = cp.mantle },

			-- Selection
			TelescopeSelection = { bg = cp.surface0 },
			TelescopeSelectionCaret = { fg = cp.surface0, bg = cp.surface0 },
			TelescopeMultiSelection = { bg = cp.surface0 },

			-- Titles
			TelescopeTitle = { fg = cp.mantle, bg = cp.mantle },
			TelescopePromptTitle = { fg = cp.base, bg = cp.mauve, style = { "bold" } },
			-- TelescopePreviewTitle = { fg = cp.red, bg = cp.crust },
			-- TelescopeResultsTitle = { fg = cp.mantle, bg = cp.mantle },

			-- Others
			TelescopePromptPrefix = { fg = cp.mauve, bg = surface_half },
			TelescopeMatching = { fg = cp.peach },
			TelescopePromptCounter = { fg = cp.surface2, bg = surface_half },

			-- [ IndentBlankline ]
			IndentBlanklineChar = { fg = indent },
			IndentBlanklineContextChar = { fg = indent_context },

			-- [ Fold Preview ]
			Folded = { fg = cp.subtext0, bg = folded_bg },
			FoldPreview = { bg = cp.surface0 },
			FoldPreviewBorder = { fg = cp.surface0, bg = cp.surface0 },

			-- [ StatusLine ]
			StatusLine = { fg = cp.base, bg = cp.base },
			StatusLineTerm = { fg = cp.base, bg = cp.base },

			-- [ Bufferline ]
			BufferLineFill = { bg = cp.mantle },
			-- buffers
			BufferLineBackground = { fg = cp.surface1, bg = cp.mantle },
			BufferLineBackcrust = { fg = cp.text, bg = cp.mantle }, -- others
			BufferLineBufferVisible = { fg = cp.surface1, bg = cp.mantle, style = { "bold", "italic" } },
			BufferLineBufferSelected = { fg = cp.text, bg = cp.base, style = { "bold", "italic" } }, -- current
			-- tabs
			BufferLineTab = { fg = cp.surface1, bg = cp.base },
			BufferLineTabSelected = { fg = cp.sky, bg = cp.base },
			BufferLineTabClose = { fg = cp.surface2, bg = cp.base },
			BufferLineIndicatorSelected = { fg = cp.mauve, bg = cp.base },
			-- separators
			BufferLineSeparator = { fg = cp.crust, bg = cp.base },
			BufferLineSeparatorVisible = { fg = cp.crust, bg = cp.base },
			BufferLineSeparatorSelected = { fg = cp.crust, bg = cp.base },
			-- close buttons
			-- BufferLineCloseButton = { fg = cp.surface1, bg = inactive_bg },
			-- BufferLineCloseButtonVisible = { fg = cp.surface1, bg = inactive_bg },
			-- BufferLineCloseButtonSelected = { fg = cp.mauve, bg = cp.base },
			-- Empty fill

			-- [ Illuminate ]
			IlluminatedWordText = { bg = cp.surface0 },
			IlluminatedWordRead = { bg = cp.surface0 },
			IlluminatedWordWrite = { bg = cp.surface0 },

			-- [ Trouble ]
			TroubleNormal = { bg = cp.crust },

			-- [ Syntax ]
			debugPC = { bg = debug_bg },
		},
	})

	-- Enable colorscheme
	vim.cmd([[colorscheme catppuccin]])
end)
