local status_ok, notify = pcall(require, "notify")
if not status_ok then
    return
end

notify.setup({
    stages = "fade",        -- Animation style (see below for details)
    render = "default",     -- Render function for notifications. See notify-render()
    timeout = 4000,         -- Default timeout for notifications
    on_open = nil,          -- Function called when a new window is opened, use for changing win settings/config
    on_close = nil,         -- Function called when a window is closed
    max_width = nil,
    max_height = nil,
    minimum_width = 50,

    -- INFO: a highlight group | an RGB hex | a function
    background_colour = "Normal",    -- The highlight behind the window

    -- Icons for the different levels
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    },
})

vim.notify = notify
