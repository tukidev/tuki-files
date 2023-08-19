local keymaps = {
  insert_mode = {
    ["<A-j>"] = "<cmd>m .+1<cr>==gi", -- Rove current line / block with Alt-j/k ala vscode.
    ["<A-k>"] = "<cmd>m .-2<cr>==gi", -- Rove current line / block with Alt-j/k ala vscode.

    -- navigation
    ["<A-Up>"] = "<C-\\><C-N><C-w>k",
    ["<A-Down>"] = "<C-\\><C-N><C-w>j",
    ["<A-Left>"] = "<C-\\><C-N><C-w>h",
    ["<A-Right>"] = "<C-\\><C-N><C-w>l",
  },

  normal_mode = {
    -- Better window movement
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Splitting
    ["<C-s><C-s>"] = "<cmd>sp<cr>",
    ["<C-s><C-v>"] = "<cmd>vsp<cr>",
    -- ["<C-f>"] = "<cmd>FocusMaxOrEqual<cr>",

    -- Resize with arrows
    ["<C-Up>"] = "<cmd>resize -2<CR>",
    ["<C-Down>"] = "<cmd>resize +2<CR>",
    ["<C-Left>"] = "<cmd>vertical resize -2<CR>",
    ["<C-Right>"] = "<cmd>vertical resize +2<CR>",

    -- Tab switch buffer
    -- ["<S-l>"] = "<CMD>BufferLineCycleNext<CR>",
    -- ["<S-h>"] = "<CMD>BufferLineCyclePrev<CR>",

    -- Rove current line / block with Alt-j/k a la vscode.
    ["<A-j>"] = "<cmd>m .+1<CR>==",
    ["<A-k>"] = "<cmd>m .-2<CR>==",

    ["K"] = function() require("neoscroll").scroll(-vim.wo.scroll, true, 220) end,
    ["J"] = function() require("neoscroll").scroll(vim.wo.scroll, true, 220) end,


    -- Folds
    ["zz"] = "zR",
    ["zi"] = "zc",
    ["zI"] = "zC",

    -- QuickFix
    -- ["fj"] = ":cnext<CR>",
    -- ["fk"] = ":cprev<CR>",
    -- ["<C-q>"] = ":call QuickFixToggle()<CR>",

    -- Hop
    ["gw"] = { "<cmd>HopWord<cr>", "Hop Word" },
    ["gW"] = { "<cmd>HopWordCurrentLine<cr>", "Hop Word at Line" },
    ["gl"] = { "<cmd>HopLineStart<cr>", "Hop Line Start" },
    ["gL"] = { "<cmd>HopLine<cr>", "Hop Line" },
    ["gs"] = { "<cmd>HopChar1<cr>", "Hop Char1" },
    ["gS"] = { "<cmd>HopChar2<cr>", "Hop Char2" },
    ["gp"] = {
      function()
        vim.cmd("HopLineStart")
        vim.schedule(function()
          vim.cmd("normal! p")
        end)
      end,
      "Hop Paste After",
    },
    ["gP"] = {
      function()
        vim.cmd("HopWord")
        vim.schedule(function()
          vim.cmd("normal! P")
        end)
      end,
      "Hop Paste Before",
    },
    ["go"] = {
      function()
        vim.cmd("HopLineStart")
        vim.schedule(function()
          vim.cmd("normal! o")
          vim.cmd("normal! o")
          vim.cmd("startinsert")
        end)
      end,
      "Hop Insert Line Below",
    },
    ["gO"] = {
      function()
        vim.cmd("HopLineStart")
        vim.schedule(function()
          vim.cmd("normal! O")
          vim.cmd("normal! O")
          vim.cmd("startinsert")
        end)
      end,
      "Hop Insert Line Above",
    },
    ["fw"] = {
      function()
        require("hop").hint_words({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        })
      end,
      "Go Forward Word",
    },
    ["Fw"] = {
      function()
        require("hop").hint_words({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        })
      end,
      "Go Forward Word Back",
    },
    ["tw"] = {
      function()
        require("hop").hint_words({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      "Go Till Word",
    },
    ["Tw"] = {
      function()
        require("hop").hint_words({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      "Go Till Word Back",
    },

    -- Harpoon
    ["g1"] = function()
      require("harpoon.ui").nav_file(1)
    end,
    ["g2"] = function()
      require("harpoon.ui").nav_file(2)
    end,
    ["g3"] = function()
      require("harpoon.ui").nav_file(3)
    end,
    ["g4"] = function()
      require("harpoon.ui").nav_file(4)
    end,
    ["gm"] = function()
      require("harpoon.ui").nav_next()
    end,
    ["gM"] = function()
      require("harpoon.ui").nav_prev()
    end,

    -- Smooth scrolling (neoscroll)

    --- [ DAP ]
    ["<F1>"] = function() require("dap").toggle_breakpoint() end,
    ["<F2>"] = function() require("dap").terminate() end,
    ["<F5>"] = function() require("dap").continue() end,
    ["<F10>"] = function() require("dap").step_over() end,
    ["<F11>"] = function() require("dap").step_into() end,
    ["<F12>"] = function() require("dap").step_out() end,
  },

  term_mode = {
    -- Terminal window navigation
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",
  },

  visual_mode = {
    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",
    --[[
    ["gw"] = { "<cmd>HopWord<cr>", "blank" },
    ["gW"] = { "<cmd>HopWordCurrentLine<cr>", "Hop Word at Line" },
    ["gl"] = { "<cmd>HopLineStart<cr>", "Hop Line Start" },
    ["gL"] = { "<cmd>HopLine<cr>", "Hop Line" },
    ["gs"] = { "<cmd>HopChar1<cr>", "Hop Char1" },
    ["gS"] = { "<cmd>HopChar2<cr>", "Hop Char2" },
    ["fw"] = {
      function()
        require("hop").hint_words({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        })
      end,
      "Go Forward Word",
    },
    ["Fw"] = {
      function()
        require("hop").hint_words({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        })
      end,
      "Go Forward Word Back",
    },
    ["tw"] = {
      function()
        require("hop").hint_words({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      "Go Till Word",
    },
    ["Tw"] = {
      function()
        require("hop").hint_words({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      "Go Till Word Back",
    },
    --]]
  },

  visual_block_mode = {
    -- Rove selected line / block of text in visual mode
    ["K"] = ":move '<-2<CR>gv=gv",
    ["J"] = ":move '>+1<CR>gv=gv",

    -- Rove current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = ":m '>+1<CR>gv=gv",
    ["<A-k>"] = ":m '<-2<CR>gv=gv",
  },

  command_mode = {
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
  },
}

return keymaps
