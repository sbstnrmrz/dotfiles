
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-l>", vim.cmd.bn)

vim.keymap.set("n", "<C-Left>", vim.cmd.tabprevious)
vim.keymap.set("n", "<C-Right>", vim.cmd.tabnext)

vim.keymap.set("n", "<C-t>", vim.cmd.tabnew)
