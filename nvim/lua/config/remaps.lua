vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
vim.keymap.set('n', '<C-[>', '<Esc>', {remap = true})

vim.keymap.set("n", "<C-l>", vim.cmd.bn)
vim.keymap.set("n", "<C-h>", vim.cmd.bp)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
