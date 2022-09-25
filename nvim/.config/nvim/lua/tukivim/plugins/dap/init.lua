import("dap", function(dap)
	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg" })

	dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

end)
