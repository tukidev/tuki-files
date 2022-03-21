local saga = vim.tukivim.register("lspsaga")
local icons = vim.tukivim.res.icons

local config = {
    use_saga_diagnostic_sign = true,
    error_sign = icons.indicators.times,
    warn_sign = icons.indicators.warning,
    hint_sign = icons.indicators.hint,
    infor_sign = icons.indicators.info_circle_c,
    dianostic_header_icon = ' ' .. icons.indicators.bug .. ' ',
    code_action_icon = ' ',
    finder_definition_icon = '  ',
    finder_reference_icon = '  ',
    definition_preview_icon = '  ',
    rename_prompt_prefix = '➤',

    max_preview_lines = 10,             -- preview lines of lsp_finder and definition preview

    code_action_prompt = {
      enable = true,
      sign = false,
      sign_priority = 20,
      virtual_text = false,
    },
    finder_action_keys = {
        open = 'o',
        vsplit = 's',
        split = 'i',
        quit = 'q',
        scroll_down = '<C-f>',
        scroll_up = '<C-b>'
    },
    code_action_keys    = { quit = 'q'    , exec = '<CR>' },
    rename_action_keys  = { quit = '<C-c>', exec = '<CR>' },

    border_style = "round",            -- INFO: "single" "double" "round" "plus"

    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = {metals = {'sbt', 'scala'}}
    server_filetype_map = {}
}

saga.init_lsp_saga(config)
