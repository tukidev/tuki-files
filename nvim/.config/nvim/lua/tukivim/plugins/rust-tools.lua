import("rust-tools", function(rt)
	local extension_path = vim.env.HOME .. "/.vscode-oss/extensions/vadimcn.vscode-lldb-1.7.0/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

	local handlers = require("tukivim.plugins.lsp.handlers")
	local keymap_loader = require("tukivim.com.keymaps.loader")

	local keymaps = {
		normal_mode = {
			h = { "<cmd>RustHoverAction<cr>", "Rust Hover Action" },
			q = { "<cmd>RustOpenExternalDocs<cr>", "Web Docs" },
			l = { "<cmd>RustJoinLines<cr>", "Rust Join Lines" },
			c = { "<cmd>RustOpenCargo<cr>", "Cargo Toml" },
			p = { "<cmd>RustParentModule<cr>", "Parent Module" },
			g = { "<cmd>RustRunnables<cr>", "Rust Runnables" },
			G = { "<cmd>RustDebuggables<cr>", "Rust Debuggables" },
			R = { "<cmd>RustReloadWorkspace<cr>", "Rust Reload Workspace" },
		},
	}

	rt.setup({
		tools = {
			reload_workspace_from_cargo_toml = true,

			inlay_hints = {
				auto = true,
				only_current_line = false,
				show_parameter_hints = true,
				parameter_hints_prefix = "<- ",
				other_hints_prefix = "=> ",

				max_len_align = false,
				max_len_align_padding = 1,

				right_align = false,
				right_align_padding = 7,

				highlight = "Comment",
			},

			hover_actions = {
				auto_focus = true,
			},

			crate_graph = {
				-- Backend used for displaying the graph
				-- see: https://graphviz.org/docs/outputs/
				-- default: x11
				backend = "x11",
				-- where to store the output, nil for no output stored (relative
				-- path from pwd)
				-- default: nil
				output = nil,
				-- true for all crates.io and external crates, false only the local
				-- crates
				-- default: true
				full = true,
				-- List of backends found on: https://graphviz.org/docs/outputs/
				-- Is used for input validation and autocompletion
				-- Last updated: 2021-08-26
				-- enabled_graphviz_backends = {},
			},
		},

		-- all the opts to send to nvim-lspconfig
		-- these override the defaults set by rust-tools.nvim
		-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
		server = {
			capabilities = handlers.defaults.capabilities,
			on_attach = function(client, bufnr)
				handlers.defaults.on_attach(client, bufnr)
				keymap_loader.load_keymaps_wk(keymaps, "f", bufnr)
			end,
			-- standalone file support
			-- setting it to false may improve startup time
			standalone = true,
		}, -- rust-analyer options

		-- debugging stuff
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	})
end)
