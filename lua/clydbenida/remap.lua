local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete work backwards
keymap.set("n", "dw", "vbd")

-- Diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)
keymap.set("n", "ds", vim.diagnostic.open_float)

-- Terminal keymaps
keymap.set('t', '<esc><esc>', [[<C-\><C-n>]])

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Tab
keymap.set("n", "te", ":tabnew<CR>", opts)
keymap.set("n", "<tab>", "gt", opts)
keymap.set("n", "<S-tab>", "gT", opts)

-- Split
keymap.set("n", "ss", "<C-w>s", opts)
keymap.set("n", "sv", "<C-w>v", opts)

-- Move across splits
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sl", "<C-w>l", opts)

-- Resize splits
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")
