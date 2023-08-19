-- INFO: to be loaded using `which-key` plugin

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

local keymaps = {
  normal_mode = {
    ["q"] = { "<cmd>q<CR>", "[q]uit" },
    ["Q"] = { "<cmd>qa!<CR>", "[Q]uit All" },
    ["w"] = { "<cmd>w!<CR>", "[w]rite file" },
    ["h"] = { "<cmd>nohlsearch<CR>", "[h]ighlighting off" },
    ["N"] = { "<cmd>Telescope notify<CR>", "[N]otify History" },
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "Open file [e]xplorer" },
    ["z"] = { "<cmd>TSJToggle<cr>", "Split-Join Toogle" },
    ["L"] = { "<cmd>Lazy<cr>", "[L]azy (Plugin Manager)" },
    ["c"] = { function() require("mini.bufremove").delete(0, false) end, "[c]lose Buffer" },
    ["C"] = { function() require("mini.bufremove").delete(0, true) end, "[C]lose Buffer (Force)" },
    ["m"] = { function() require("harpoon.mark").add_file() end, "Add file mark" },
    ["M"] = { function() require("harpoon.mark").rm_file() end, "Remove file mark" },
    ["/"] = { function() require("Comment.api").toggle.linewise.current() end, "Comment" },
    ["?"] = { function() require("Comment.api").toggle.blockwise.current() end, "Comment Blockwise" },
    d = {
      name = "[D]AP",
      u = { function() require("dapui").toggle() end, "dap Toogle [U]I" },
      r = { function() require("dap").repl.toggle() end, "dap Toogle [r]epl" },
      l = { function() require("dap").run_last() end, "dap Run [l]ast" },
      d = { function() require("dap").continue() end, "[d]ebug" },
      p = { function() require("dap").pause() end, "[p]ause" },
      b = { function() require("telescope").extensions.dap.list_breakpoints() end, "dap [b]reakpoints" },
      w = { function() require("dap.ui.widgets").hover() end, "dap [w]idget hover" },
      W = {
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.scopes)
        end,
        "dap [W]idget scope",
      },
      c = {
        function()
          require("telescope").extensions.dap.commands({ layout_config = { width = 0.4, height = 16 } })
        end,
        "dap [C]ommands",
      },
    },
    v = {
      name = "Neo[v]im",
      s = { name = "[s]ession" },
    },
    s = {
      name = "[S]earch",
      g = { require("telescope.builtin").git_branches, "checkout [G]it branches" },
      f = {
        function()
          require("telescope.builtin").find_files({
            previewer = false,
            hidden = true,
            layout_config = { width = 0.4, height = 16 },
          })
        end,
        "search [F]ile",
      },
      F = { require("telescope.builtin").find_files, "search [F]ile Preview" },
      S = { function() require("telescope.builtin").live_grep({ hidden = true }) end, "search [S]ymbols (hidden)" },
      s = { require("telescope.builtin").live_grep, "search [s]ymbols" },
      h = { require("telescope.builtin").help_tags, "search [h]elp" },
      b = { require("telescope.builtin").buffers, "search [b]uffers" },
      r = { require("telescope.builtin").oldfiles, "search [r]ecent File" },
      R = { require("telescope.builtin").registers, "search [R]egisters" },
      k = { require("telescope.builtin").keymaps, "search [k]eymaps" },
      c = { require("telescope.builtin").commands, "search [c]ommands" },
      p = { "<cmd>Telescope projects<cr>", "search [P]roject Files" },
      m = { "<cmd>Telescope harpoon marks<cr>", "search [M]arks" },
      d = {
        name = "[D]AP",
        --[[
        b = {
					function()
						require("telescope").extensions.dap.list_breakpoints()
					end,
					"dap [B]reakpoints",
				},
				c = {
					function()
						require("telescope").extensions.dap.configurations()
					end,
					"dap [C]onfigurations",
				},
				v = {
					function()
						require("telescope").extensions.dap.variables()
					end,
					"dap [V]ariable",
				},
				f = {
					function()
						require("telescope").extensions.dap.frames()
					end,
					"dap [F]rames",
				},
        --]]
      },
    },
    S = {
      name = "[S]pectre",
      S = { function() require("spectre").toggle() end, "Spectre Toggle" },
      w = { function() require("spectre").open_visual({ select_word = true }) end, "S&R current word" },
    },
    G = {
      name = "Git",
      -- j = { function() require 'gitsigns'.next_hunk() end, "Next Hunk" },
      -- k = { function() require 'gitsigns'.prev_hunk() end, "Prev Hunk" },
      -- l = { function() require 'gitsigns'.blame_line() end, "Blame" },
      -- p = { function() require 'gitsigns'.preview_hunk() end, "Preview Hunk" },
      -- r = { function() require 'gitsigns'.reset_hunk() end, "Reset Hunk" },
      -- R = { function() require 'gitsigns'.reset_buffer() end, "Reset Buffer" },
      -- s = { function() require 'gitsigns'.stage_hunk() end, "Stage Hunk" },
      -- u = { function() require 'gitsigns'.undo_stage_hunk() end, "Undo Stage Hunk" },
      v = {
        name = "View",
        o = { "<cmd>Telescope git_status<cr>", "View changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
      },
      -- g = { "<cmd>Neogit<cr>", "Open git status" },
      -- c = { "<cmd>Neogit commit<cr>", "Commit" },
      d = { "<cmd>DiffviewOpen<cr>", "Diffview Open" },
      D = { "<cmd>DiffviewClose<cr>", "Diffview Close" },
      h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
      e = { "<cmd>DiffviewToggleFiles<cr>", "Diffview Explorer" },
    },

    l = {
      name = "[L]SP",

      D = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document [D]iagnostic" },
      d = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace [d]iagnostic" },
      Q = { "<cmd>Trouble quickfix<cr>", "[Q]uickfix" },
      w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      f = { vim.lsp.buf.format, "lsp [F]ormat buffer" },
      -- i = { "<cmd>LspInfo<cr>", "[I]nfo" },
      -- I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
      j = { vim.diagnostic.goto_next, "Next Diagnostic" },
      k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      m = { "<cmd>Mason<cr>", "[M]ason" },
      q = { vim.diagnostic.setloclist, "Quickfix" },
      r = { vim.lsp.buf.rename, "[R]ename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document [S]ymbols" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace [S]ymbols" },
    },

    --[[
		s = {
			name = "Session",

			s = { require("possession.commands").save, "Save" },
			d = { require("possession.commands").delete, "Delete" },
			l = { require("possession.commands").list, "List" },
			c = { require("possession.commands").close, "Close" },
			i = { require("possession.commands").show, "Show" },
			o = { require("possession.commands").load, "Load" },
		},
    --]]

    u = {
      name = "[U]I",

      a = { "<cmd>[A]lpha<cr>", "Alpha" },
      C = { "<cmd>Toggle [C]olorizer<cr>", "Toggle Colors" },
      c = { "<cmd>[C]atppuccin Compile<cr>", "Colorscheme Compile" },
      -- z = { "<cmd>TZAttraxis<CR>", "Toggle Zen Mode" },
      -- m = { "<cmd>TZMinimalist<CR>", "Toggle Minimalist Mode" },
      i = { "<cmd>IndentBlanklineToggle<cr>", "Toggle [I]ndent-Blankline" },
      t = { "Telescope colorscheme", "Colorschemes" },
    },
  },
  visual_mode = {
    l = {
      name = "[L]SP",

      f = { vim.tukivim.utils.formatSelection, "[F]ormat selection" },
    },
    ["/"] = {
      function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        require("Comment.api").toggle.linewise(vim.fn.visualmode())
      end,
      "Comment",
    },
    ["?"] = {
      function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        require("Comment.api").toggle.blockwise(vim.fn.visualmode())
      end,
      "Comment block",
    },
    -- ["z"] = { "<cmd>'<,'>TZAttraxis<CR>", "Zen"}
  },
}

return keymaps
