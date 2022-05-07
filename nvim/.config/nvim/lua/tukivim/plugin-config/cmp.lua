local cmp = vim.tukivim.utils.psetup("cmp")
local luasnip = vim.tukivim.utils.psetup("luasnip") -- load LuaSnip plugin

require("luasnip/loaders/from_vscode").lazy_load() -- load snipets from VSCode

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = vim.tukivim.res.icons.cmp


local default_mappings = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),

    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expandable() then
            luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif check_backspace() then
            fallback()
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
}

local conf = {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- INFO: for `luasnip` plugin
		end,
	},
	mapping = default_mappings,

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]

			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
}


local default_mapping_cmdline = cmp.mapping.preset.insert({
    ['<C-j>'] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
        },
    ['<C-k>'] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    },
    ['<C-c>'] = {
      c = cmp.mapping.close(),
    },
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = default_mapping_cmdline,
  sources = {
    { name = 'buffer' }
  }
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = default_mapping_cmdline,
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


cmp.setup(conf)
