import("cmp", function(cmp)
	local luasnip = require("luasnip")
	require("luasnip/loaders/from_vscode").lazy_load()

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	local kind_icons = vim.tukivim.res.icons.cmp

	local default_mappings = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		-- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-Space>"] = function()
			if cmp.visible() then
				return cmp.mapping(cmp.close(), { "i", "c" })
			else
				-- return cmp.mapping({
				--      i = cmp.abort(),
				--      c = cmp.close(),
				--    })
				return cmp.mapping(cmp.complete(), { "i", "c" })
			end
		end,
		["<C-y>"] = cmp.config.disable,
		["<C-c>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),

		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
	}

	local conf = {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- INFO: for `luasnip` plugin
			end,
		},
		mapping = default_mappings,

		formatting = {
			fields = { "abbr", "kind" },
			format = function(_, vim_item)
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
				-- vim_item.menu = ({
				-- 	nvim_lsp = "[LSP]",
				-- 	luasnip = "[Snippet]",
				-- 	buffer = "[Buffer]",
				-- 	rg = "[Grep]",
				-- 	path = "[Path]",
				-- })[entry.source.name]

				return vim_item
			end,
		},
		sources = {
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "rg" },
			{ name = "path" },
		},
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require("cmp-under-comparator").under,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
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
			ghost_text = false,
			native_menu = false,
		},
	}

	local default_mapping_cmdline = cmp.mapping.preset.insert({
		["<C-j>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
		},
		["<C-k>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		},
		["<C-c>"] = {
			c = cmp.mapping.close(),
		},
	})

	-- `/` cmdline setup.
	cmp.setup.cmdline("/", {
		mapping = default_mapping_cmdline,
		sources = {
			{ name = "buffer" },
		},
	})

	-- `:` cmdline setup.
	cmp.setup.cmdline(":", {
		mapping = default_mapping_cmdline,
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	cmp.setup(conf)
end)
