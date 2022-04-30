local U = vim.tukivim.utils
local dap = U.preq("dap")

--- [ Icons ]
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg" })

--- [ Defaults ]
dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

--- [ Extensions ]
require("tukivim.plugin-config.dap.virt")
require("tukivim.plugin-config.dap.ui")

--- [ Languages Tools ]
U.preq("tukivim.plugin-config.dap.lang.python")
U.preq("tukivim.plugin-config.dap.lang.rusttools")
