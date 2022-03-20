local status, saga = pcall(require, 'lspsaga')
if not status then
    vim.notify("Error while calling plugin: LSP-SAGA", "Error")
    return
end

local R = require("tukivim.master.res")


local config = {
    use_saga_diagnostic_sign = true,
    error_sign = R.icons.indicators.times,
    warn_sign = R.icons.indicators.warning,
    hint_sign = R.icons.indicators.hint,
    infor_sign = R.icons.indicators.info_circle_c,
    dianostic_header_icon = ' ' .. R.icons.indicators.bug .. ' ',
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
