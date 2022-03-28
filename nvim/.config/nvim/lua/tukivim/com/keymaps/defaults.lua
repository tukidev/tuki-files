local keymaps = {
    insert_mode = {
        ["<A-j>"] = "<Esc>:m .+1<CR>==gi",        -- Rove current line / block with Alt-j/k ala vscode.
        ["<A-k>"] = "<Esc>:m .-2<CR>==gi",        -- Rove current line / block with Alt-j/k ala vscode.

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

        -- Resize with arrows
        ["<C-Up>"] = ":resize -2<CR>",
        ["<C-Down>"] = ":resize +2<CR>",
        ["<C-Left>"] = ":vertical resize -2<CR>",
        ["<C-Right>"] = ":vertical resize +2<CR>",

        -- Tab switch buffer
        ["<S-l>"] = ":BufferLineCycleNext<CR>",
        ["<S-h>"] = ":BufferLineCyclePrev<CR>",

        -- Rove current line / block with Alt-j/k a la vscode.
        ["<A-j>"] = ":m .+1<CR>==",
        ["<A-k>"] = ":m .-2<CR>==",

        -- QuickFix
        ["fj"] = ":cnext<CR>",
        ["fk"] = ":cprev<CR>",
        ["<C-q>"] = ":call QuickFixToggle()<CR>",

        ["gw"] = "<cmd>HopWord<cr>",
        ["gW"] = "<cmd>HopWordCurrentLine<cr>",
        ["gl"] = "<cmd>HopLineStart<cr>",
        ["gL"] = "<cmd>HopLine<cr>",
        ["gs"] = "<cmd>HopChar1<cr>",
        ["gS"] = "<cmd>HopChar1CurrentLine<cr>",
        -- [""] = "",
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

        -- ["p"] = '"0p',
        -- ["P"] = '"0P',
    },

    visual_block_mode = {
        -- Rove selected line / block of text in visual mode
        ["K"] = ":move '<-2<CR>gv-gv",
        ["J"] = ":move '>+1<CR>gv-gv",

        -- Rove current line / block with Alt-j/k ala vscode.
        ["<A-j>"] = ":m '>+1<CR>gv-gv",
        ["<A-k>"] = ":m '<-2<CR>gv-gv",
    },

    command_mode = {
        -- navigate tab completion with <c-j> and <c-k>
        -- runs conditionally
        ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
        ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
    },
}

return require("tukivim.com.keymaps.loader").setup(keymaps)

-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
-- keymap("n", "<leader>t", "<cmd>Telescope live_grep<cr>", opts)
