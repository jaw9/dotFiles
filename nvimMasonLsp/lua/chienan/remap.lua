vim.g.mapleader = " "
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

local opts = { noremap = true, silent = true }

-- move line up and down when in v mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
-- stay at middle line when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
-- append next lien to the end of current line without move the cursor
vim.keymap.set("n", "J", "mzJ`z", opts)
-- yank into the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Shortcut for faster save and quit
vim.keymap.set("n", "<leader>w", ":<C-U>update<CR>", opts)
-- disable captial q to quit just in case
vim.keymap.set("n", "Q", "<nop>")
-- Close a buffer and switching to another buffer, do not close the
-- window, see https://stackoverflow.com/q/4465095/6064933
vim.keymap.set("n", "<leader>x", ":<C-U>bprevious <bar> bdelete #<CR>", opts)
-- Move among buffers with mapleader"
vim.keymap.set("", "<leader>.", ":bnext<CR>", opts)
vim.keymap.set("", "<leader>,", ":bprev<CR>", opts)
-- Split
vim.keymap.set("n", "<leader>h", ":<C-U>split<CR>", opts)
vim.keymap.set("n", "<leader>v", ":<C-U>vsplit<CR>", opts)
-- Undo Panel
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", otps)
