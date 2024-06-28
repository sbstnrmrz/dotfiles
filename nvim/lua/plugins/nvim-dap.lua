return {
    'https://github.com/mfussenegger/nvim-dap',
    config = function ()
        local dap = require("dap")

        vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint)
        vim.keymap.set('n', '<Leader>dc', dap.continue)
    end
}
