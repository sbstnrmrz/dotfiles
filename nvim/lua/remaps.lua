vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-l>", vim.cmd.bn)
vim.keymap.set("n", "<C-h>", vim.cmd.bp)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

--vim.keymap.set("n", "<C-Left", vim.cmd.bp)
--vim.keymap.set("n", "<C-Right>", vim.cmd.bn)

--vim.keymap.set("n", "<C-t>", vim.cmd.tabnew)
