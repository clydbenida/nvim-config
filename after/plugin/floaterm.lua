-- Mostly Remaps for Floaterm

vim.keymap.set("n", "<leader>tt", '<cmd>FloatermToggle<cr>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>te", '<cmd>FloatermKill<cr>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", '<cmd>FloatermNext<cr>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tp", '<cmd>FloatermPrev<cr>', { noremap = true, silent = true })
vim.keymap.set("t", "<C-\\><C-n>", '<cmd>FloatermNew<cr>', { noremap = true, silent = true })

vim.g.floaterm_autoinsert = false
