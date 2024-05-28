vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "ds", vim.diagnostic.open_float)
vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]])
