local configurations = {
  'packer',

  'tukivim.colorschemes.material',

  'tukivim.plugin-config.autopairs',
  'tukivim.plugin-config.bufferline',
  'tukivim.plugin-config.cmp',
  'tukivim.plugin-config.colorizer',
  'tukivim.plugin-config.comment',
  'tukivim.plugin-config.gitsigns',
  'tukivim.plugin-config.lualine',
  'tukivim.plugin-config.mappings',
  'tukivim.plugin-config.mtelescope',
  'tukivim.plugin-config.nvim-tree',
  'tukivim.plugin-config.options',
  'tukivim.plugin-config.toggleterm',
  'tukivim.plugin-config.treesitter',
  'tukivim.plugin-config.whichkey',
}

local function require_configs(configs)
  for _, config in ipairs(configs) do
    require(config)
  end
end

require_configs(configurations)
