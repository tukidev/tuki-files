local UTILS = require("tukivim.c.utils")
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

return {
  ["default"]        = {
    {
      "<A-j>",
      "<cmd>m .+1<cr>==gi",
      desc = "Rove line down",
      mode = { "i", "n" },
    },
    {
      "<A-k>",
      "<cmd>m .-2<cr>==gi",
      desc = "Rove line up",
      mode = { "i", "n" },
    },

    -- Better window movement
    -- { "<C-h>",      "<C-w>h",                                           desc = "" },
    -- { "<C-j>",      "<C-w>j",                                           desc = "" },
    -- { "<C-k>",      "<C-w>k",                                           desc = "" },
    -- { "<C-l>",      "<C-w>l",                                           desc = "" },
    -- INFO: use 'vim-tmux-navigator' plugin insteed

    -- Splitting
    { "<C-s><C-s>", "<cmd>sp<cr>",                                      desc = "" },
    { "<C-s><C-v>", "<cmd>vsp<cr>",                                     desc = "" },
    -- ["<C-f>"] = "<cmd>FocusMaxOrEqual<cr>",

    -- Resize with arrows
    { "<C-Up>",     "<cmd>resize -2<CR>",                               desc = "" },
    { "<C-Down>",   "<cmd>resize +2<CR>",                               desc = "" },
    { "<C-Left>",   "<cmd>vertical resize -2<CR>",                      desc = "" },
    { "<C-Right>",  "<cmd>vertical resize +2<CR>",                      desc = "" },


    -- Rove current line / block with Alt-j/k a la vscode.
    { "<A-j>",      "<cmd>m .+1<CR>==",                                 desc = "" },
    { "<A-k>",      "<cmd>m .-2<CR>==",                                 desc = "" },

    -- Folds
    { "zz",         "zR",                                               desc = "" },
    { "zi",         "zc",                                               desc = "" },
    { "zI",         "zC",                                               desc = "" },

    -- QuickFix
    -- ["fj"] = ":cnext<CR>",
    -- ["fk"] = ":cprev<CR>",
    -- ["<C-q>"] = ":call QuickFixToggle()<CR>",

    { "<leader>q",  "<cmd>q<CR>",                                       desc = "[q]uit" },
    { "<leader>Q",  "<cmd>qa!<CR>",                                     desc = "[Q]uit All" },
    { "<leader>w",  "<cmd>w!<CR>",                                      desc = "[w]rite file" },
    { "<leader>h",  "<cmd>nohlsearch<CR>",                              desc = "[h]ighlighting off" },
    { "<leader>N",  "<cmd>Telescope notify<CR>",                        desc = "[N]otify History" },
    { "<leader>z",  "<cmd>TSJToggle<cr>",                               desc = "Split-Join Toogle" },
    -- { "<leader>L",  "<cmd>Lazy<cr>",                                    desc = "[L]azy (Plugin Manager)" },

    -- [ LSP ]
    { "<leader>lD", "<cmd>Telescope diagnostics<cr>",                   desc = "Diagnostics" },
    { "<leader>lf", vim.lsp.buf.format,                                 desc = "lsp [F]ormat buffer" },
    { "<leader>li", "<cmd>LspInfo<cr>",                                 desc = "[I]nfo" },
    { "<leader>lI", "<cmd>LspInstallInfo<cr>",                          desc = "Installer Info" },
    { "<leader>lj", vim.diagnostic.goto_next,                           desc = "Next Diagnostic" },
    { "<leader>lk", vim.diagnostic.goto_prev,                           desc = "Prev Diagnostic" },
    { "<leader>lq", vim.diagnostic.setloclist,                          desc = "Quickfix" },
    { "<leader>lr", vim.lsp.buf.rename,                                 desc = "[R]ename" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Document [S]ymbols" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace [S]ymbols" },
    {
      "<leader>lf",
      mode = "v",
      function()
        vim.lsp.buf.format({
          async = true,
          range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"]   = vim.api.nvim_buf_get_mark(0, ">"),
          },
        })
      end,
      desc = "[F]ormat selection",
    },

    { "<esc>", [[<C-\><C-n>]],      mode = { "t" } },
    { "<C-h>", "<cmd>wincmd h<cr>", mode = { "t" } },
    { "<C-j>", "<cmd>wincmd j<cr>", mode = { "t" } },
    { "<C-k>", "<cmd>wincmd k<cr>", mode = { "t" } },
    { "<C-l>", "<cmd>wincmd l<cr>", mode = { "t" } },
  },

  ["dap"]            = {
    { "<F1>",       function() require("dap").toggle_breakpoint() end,                     desc = "Toggle Breakpoint" },
    { "<F5>",       function() require("dap").continue() end,                              desc = "DAP Continue" },
    { "<F2>",       function() require("dap").terminate() end,                             desc = "DAP Terminate" },
    { "<F10>",      function() require("dap").step_over() end,                             desc = "DAP Step Over" },
    { "<F11>",      function() require("dap").step_into() end,                             desc = "DAP Step Into" },
    { "<F12>",      function() require("dap").step_out() end,                              desc = "DAP Step Out" },
    { "<leader>dd", function() require("dap").continue() end,                              desc = "[d]ebug" },
    { "<leader>dl", function() require("dap").run_last() end,                              desc = "dap Run [l]ast" },
    { "<leader>dp", function() require("dap").pause() end,                                 desc = "[p]ause" },
    { "<leader>db", function() require("telescope").extensions.dap.list_breakpoints() end, desc = "dap [b]reakpoints" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end,                      desc = "dap [w]idget hover" },
    {
      "<leader>dW",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end,
      desc = "dap [W]idget scope",
    },
    {
      "<leader>dc",
      function()
        require("telescope").extensions.dap.commands({ layout_config = { width = 0.4, height = 16 } })
      end,
      desc = "dap [C]ommands",
    },
  },

  ["dap-python"]     = {
    { "<leader>tm", function() require('dap-python').test_method() end,     desc = "Debug Method" },
    { "<leader>tc", function() require('dap-python').test_class() end,      desc = "Debug Class" },
    { "<leader>ds", function() require("dap-python").debug_selection() end, desc = "Debug Selection", mode = { "v" } },
  },

  ["dap-ui"]         = {
    { "<leader>ud", function() require("dapui").toggle() end, desc = "dap Toogle [U]I" }
  },

  ["mini-bufremove"] = {
    { "<leader>c", function() require("mini.bufremove").delete(0, false) end, desc = "[c]lose Buffer" },
    { "<leader>C", function() require("mini.bufremove").delete(0, true) end,  desc = "[C]lose Buffer (Force)" },
  },

  ["telescope"]      = {
    {
      "<leader>sf",
      function()
        require("telescope.builtin").find_files({
          previewer = false,
          hidden = true,
          layout_config = { width = 0.5, height = 20 },
        })
      end,
      desc = "search [F]ile",
    },
    {
      "<leader>sS",
      function() require("telescope.builtin").live_grep({ hidden = true }) end,
      desc = "search [S]ymbols (hidden)",
    },
    { "<leader>sg", function() require("telescope.builtin").git_branches() end, desc = "checkout [G]it branches" },
    { "<leader>sF", function() require("telescope.builtin").find_files() end,   desc = "search [F]ile Preview" },
    { "<leader>ss", function() require("telescope.builtin").live_grep() end,    desc = "search [s]ymbols" },
    { "<leader>sh", function() require("telescope.builtin").help_tags() end,    desc = "search [h]elp" },
    { "<leader>sb", function() require("telescope.builtin").buffers() end,      desc = "search [b]uffers" },
    { "<leader>sr", function() require("telescope.builtin").oldfiles() end,     desc = "search [r]ecent File" },
    { "<leader>sR", function() require("telescope.builtin").registers() end,    desc = "search [R]egisters" },
    { "<leader>sk", function() require("telescope.builtin").keymaps() end,      desc = "search [k]eymaps" },
    { "<leader>sc", function() require("telescope.builtin").commands() end,     desc = "search [c]ommands" },
    { "<leader>sp", "<cmd>Telescope projects<cr>",                              desc = "search [P]roject Files" },
  },

  ["telescope-dap"]  = {
    {
      "<leader>dc",
      function()
        require("telescope").extensions.dap.commands({ layout_config = { width = 0.4, height = 16 } })
      end,
      desc = "dap [C]ommands",
    },
    {
      "<leader>db",
      function() require("telescope").extensions.dap.list_breakpoints() end,
      desc = "dap [B]reapoints",
    },
  },

  ["harpoon"]        = {
    { "<leader>ma", function() require("harpoon.mark").add_file() end,            desc = "Add file mark" },
    { "<leader>md", function() require("harpoon.mark").rm_file() end,             desc = "Remove file mark" },
    { "<leader>mc", function() require("harpoon.cmd-ui").toggle_quick_menu() end, desc = "Command Menu" },
    { "<leader>1",  function() require("harpoon.ui").nav_file(1) end,             desc = "File 1" },
    { "<leader>2",  function() require("harpoon.ui").nav_file(2) end,             desc = "File 2" },
    { "<leader>3",  function() require("harpoon.term").gotoTerminal(1) end,       desc = "Terminal 1" },
    { "<leader>4",  function() require("harpoon.term").gotoTerminal(2) end,       desc = "Terminal 2" },
    { "<leader>5",  function() require("harpoon.term").sendCommand(1, 1) end,     desc = "Command 1" },
    { "<leader>6",  function() require("harpoon.term").sendCommand(1, 2) end,     desc = "Command 2" },
    { "<leader>sm", "<cmd>Telescope harpoon marks<cr>",                           desc = "search [M]arks" },

  },
  ["nvim-tree"]      = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Open file [e]xplorer" },
  },

  ["bufferline"]     = {
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Go to next buffer" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Go to prev buffer" },
  },

  ["spectre"]        = {
    { "<leader>Sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "S&R current word" },
    { "<leader>SS", function() require("spectre").toggle() end,                            desc = "Spectre Toggle" },
  },

  ["neoscroll"]      = {
    { "K", function() require("neoscroll").scroll(-vim.wo.scroll, true, 220) end },
    { "J", function() require("neoscroll").scroll(vim.wo.scroll, true, 220) end },
  },

  ["todo-comments"]  = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
  },

  ["ufo"]            = {
    { "zO", function() require("ufo").openAllFolds() end,               desc = "[O]ut folds" },
    { "zI", function() require("ufo").closeAllFolds() end,              desc = "[I]n folds" },
    { "zj", function() require("ufo").goNextClosedFold() end,           desc = "Next fold" },
    { "zk", function() require("ufo").goPreviousClosedFold() end,       desc = "Prev fold" },
    { "zl", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek current fold" },
  },

  ["trouble"]        = {
    { "<leader>lD", "<cmd>Trouble diagnostics toggle<cr>",              desc = "projects [D]iagnostic" },
    { "<leader>ld", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer [D]iagnostic" },
    { "<leader>lQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Trouble [Q]uickfix" },
  },

  ["flash"]          = {
    {
      "sw",
      function() require("tukivim.plugins.utils.flash").flash_word() end,
      desc = "Flash [w]ord",
      mode = { "n", "x", "o" },
    },
    {
      "sl",
      mode = { "n", "x", "o" },
      desc = "Flash [l]ine",
      function()
        require("flash").jump({
          pattern = "^",
          search = { mode = "search", max_length = 0 },
          label = { after = { 0, 0 } },
        })
      end,
    },
    { "ss",    mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash TS" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "TS Search" },
    { "r",     mode = { "o" },           function() require("flash").remote() end,            desc = "Remote Flash" },
    { "<c-f>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Search" },

  },

  ["focus"]          = {
    { "<C-s><C-f>", "<cmd>FocusToggle<cr>", desc = "Toggle [f]ocus mode" },
  },

  ["mason"]          = {
    { "<leader>lm", "<cmd>Mason<cr>", desc = "[M]ason" },
  },

  ["notify"]         = {
    {
      "<leader>un",
      function() require("notify").dismiss({ silent = true, pending = true }) end,
      desc = "Dismiss all Notifications",
    },
  },

  ["comment"]        = {
    { "<leader>/", function() require("Comment.api").toggle.linewise.current() end,  desc = "Comment" },
    { "<leader>?", function() require("Comment.api").toggle.blockwise.current() end, desc = "Comment Blockwise" },
    {
      "<leader>/",
      function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        require("Comment.api").toggle.linewise(vim.fn.visualmode())
      end,
      desc = "Comment",
      mode = "x"
    },
    {
      "<leader>?",
      function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        require("Comment.api").toggle.blockwise(vim.fn.visualmode())
      end,
      desc = "Comment Blockwise",
      mode = "x"
    },
  },

  ["treesj"]         = {
    { "<leader>z", "<cmd>TSJToggle<cr>", desc = "Split-Join Toogle" } },

  ["persistence"]    = {
    { "<leader>vss", function() require("persistence").load() end,                desc = "Restore [s]ession" },
    { "<leader>vsl", function() require("persistence").load({ last = true }) end, desc = "Restore [l]ast Session" },
    { "<leader>vsd", function() require("persistence").stop() end,                desc = "[d]elete Current Session" },
  },

  ["neotest"]        = {
    {
      "<leader>tD",
      function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,
      desc = "Debug File",
    },
    {
      "<leader>tL",
      function() require('neotest').run.run_last({ strategy = 'dap' }) end,
      desc = "Debug Last"
    },
    { "<leader>ta", function() require('neotest').run.attach() end,                  desc = "Test Attach" },
    { "<leader>tT", function() require('neotest').run.run(vim.fn.expand('%')) end,   desc = "Test File" },
    { "<leader>tl", function() require('neotest').run.run_last() end,                desc = "Test Last" },
    { "<leader>tt", function() require('neotest').run.run() end,                     desc = "Test Nearest" },
    { "<leader>td", function() require('neotest').run.run({ strategy = 'dap' }) end, desc = "Debug Nearest" },
    { "<leader>to", function() require('neotest').output.open({ enter = true }) end, desc = "Test Output" },
    { "<leader>ts", function() require('neotest').run.stop() end,                    desc = "Test Stop" },
    { "<leader>tS", function() require('neotest').summary.toggle() end,              desc = "Test Summary" },
  },

  ["overseer"]       = {
    { "<leader>:", "<cmd>OverseerRun<cr>",    desc = "Run Command" },
    { "<leader>;", "<cmd>OverseerToggle<cr>", desc = "Toggle overseer Output" },
  },

  ["venv-selector"]  = {
    { "<leader>le", "<cmd>VenvSelect<cr>", desc = "Select [V]irtualEnv" }
  },

  ["lsp-default"]    = {
    { "fD", vim.lsp.buf.declaration,                                           desc = "Go declaration" },
    { "fd", function() require("telescope.builtin").lsp_definitions() end,     desc = "Definitions" },
    { "fi", function() require("telescope.builtin").lsp_implementations() end, desc = "Implementations" },
    { "fr", function() require("telescope.builtin").lsp_references() end,      desc = "References" },
    { "fo", vim.lsp.buf.hover,                                                 desc = "Hover" },
    { "fs", vim.lsp.buf.signature_help,                                        desc = "Signature" },
    { "fk", vim.diagnostic.goto_prev,                                          desc = "Prev (diagnostic)" },
    { "fj", vim.diagnostic.goto_next,                                          desc = "Next (diagnostic)" },
    { "ff", vim.diagnostic.open_float,                                         desc = "Diagnostic" },
    { "fa", vim.lsp.buf.code_action,                                           desc = "Code Action" },
  },

  ["lsp-typescript"] = {
    { "<leader>lo", "<cmd>TypescriptOrganizeImports<CR>",      desc = "Organize Imports" },
    { "<leader>lR", "<cmd>TypescriptRenameFile<CR>",           desc = "Rename File" },
    { "fd",         "<cmd>TypescriptGoToSourceDefinition<CR>", desc = "Go to Definition (TS)" },
  },
  ["lsp-clang"]      = {
    { "<leader>lz", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
    { "<leader>lh", "<cmd>ClangdToggleInlayHints<cr>",   desc = "Toggle inlay [h]ints" }
  },

  ["lsp-python"]     = {
    -- { "<leader>lo", "<cmd>PyrightOrganizeImports<cr>", desc = "Organize Imports" },
  },

  ["lsp-java"]       = {
    { "<leader>lo", function() require("jdtls").organize_imports() end,     desc = "Organize imports" },
    { "<leader>lv", function() require("jdtls").extract_variable() end,     desc = "Extract Variable" },
    { "<leader>lc", function() require("jdtls").extract_constant() end,     desc = "Extract Constant" },
    { "<leader>lt", function() require("jdtls").test_nearest_method() end,  desc = "Test Method" },
    { "<leader>lT", function() require("jdtls").test_class() end,           desc = "Test Class" },
    { "<leader>le", function() require("jdtls").set_runtime() end,          desc = "Set [R]untime" },

    { "<leader>lv", function() require("jdtls").extract_variable(true) end, desc = "Extract Variable", mode = { "v" } },
    { "<leader>lc", function() require("jdtls").extract_constant(true) end, desc = "Extract Constant", mode = { "v" } },
    { "<leader>lm", function() require("module").extract_method(true) end,  desc = "Extract Method",   mode = { "v" } },
  },

  ["lsp-java-test"]  = {
    { "<leader>tc", function() require("jdtls.dap").test_class() end,          desc = "Run All Test" },
    { "<leader>tm", function() require("jdtls.dap").test_nearest_method() end, desc = "Run Nearest Test" },
    { "<leader>tt", function() require("jdtls.dap").pick_test() end,           desc = "Run Test" },
  },

  ["lsp-rust"]       = {
    { "fo",         "<cmd>RustHoverActions<cr>",           desc = "Hover Actions (Rust)" },
    { "fa",         "<cmd>RustCodeAction<cr>",             desc = "Code Action (Rust)" },
    { "<leader>dr", "<cmd>RustDebuggables<cr>",            desc = "Run Debuggables (Rust)" },

    { "<leader>lR", "<cmd>RustRunnables<cr>",              desc = "Runnables" },
    { "<leader>ll", function() vim.lsp.codelens.run() end, desc = "Code Lens" },
    { "<leader>lt", "<cmd>Cargo test<cr>",                 desc = "Cargo test" },
    { "<leader>lg", "<cmd>Cargo run<cr>",                  desc = "Cargo run" },
  },

  ["lsp-omnisharp"]  = {
    { "fd", function() require("omnisharp_extended").telescope_lsp_definitions() end, desc = "Goto Definition" }
  },


  ["crates"]             = {
    {
      "fo",
      function()
        if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
          require("crates").show_popup()
        else
          vim.lsp.buf.hover()
        end
      end,
      desc = "Show Crate Documentation",
    },
    { "<leader>lcr", function() require("crates").open_repository() end,         desc = "Open Repository" },
    { "<leader>lcO", function() require("crates").show_popup() end,              desc = "Show Popup" },
    { "<leader>lco", function() require("crates").show_crate_popup() end,        desc = "Show Info" },
    { "<leader>lcf", function() require("crates").show_features_popup() end,     desc = "Show Features" },
    { "<leader>lcd", function() require("crates").show_dependencies_popup() end, desc = "Show Dependencies" },
  },
  ["toggleterm"]         = {
    { [[<C-t>]],   "<cmd>ToggleTerm<cr>",                                                       desc = "Terminal" },
    { [[<C-n>]],   function() require("tukivim.plugins.utils.toggleterm").new_term() end,       desc = "New Term" },
    { "<leader>G", function() require("tukivim.plugins.utils.toggleterm").lazygit_toggle() end, desc = "LazyGit" },
  },
  ["iron"]               = {
    { "<leader>ia", "<cmd>IronAttach<cr>",  desc = "Iron [a]ttach" },
    { "<leader>ir", "<cmd>IronRepl<cr>",    desc = "Iron [r]epl" },
    { "<leader>iR", "<cmd>IronRestart<cr>", desc = "Iron [R]estart" },
    { "<leader>ih", "<cmd>IronHide<cr>",    desc = "Iron [h]ide" },
    { "<leader>ii", "<cmd>IronSend<cr>",    desc = "Iron send" },
  },
  ["zen-mode"]           = {
    { "<leader>uz", function() require("zen-mode").toggle() end, desc = "[Z]en Mode" }
  },
  ["dadbod-ui"]          = {
    { "<leader>Dd", "<cmd>DBUI<cr>",              desc = "[d]adbod" },
    { "<leader>uD", "<cmd>DBUIToggle<cr>",        desc = "toggle [D]adbod ui" },
    { "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "dbui [a]dd connection" },
    { "<leader>sD", "<cmd>DBUIFindBuffer<cr>",    desc = "searcg [D]adbod buffer" },
  },
  ["vim-tmux-navigator"] = {
    { "<C-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<C-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<C-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<C-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  }
}
