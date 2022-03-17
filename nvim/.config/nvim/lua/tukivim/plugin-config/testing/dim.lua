local status, dim = pcall(require, "dim")
if not status then
  return
end

local configuration = {
    -- disable_lsp_decorations = false,    -- disable virt text and underline by lsp on unused vars and functions
    -- change_in_insert = false,           -- change highlights in insert mode (real time updates)
}

dim.setup(configuration)
