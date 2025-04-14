return {
    "williamboman/mason.nvim",
    dependencies = {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',

        opts = {
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = { documentation = { auto_show = true } },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        }
    },
    config = function()
        require("mason").setup()
        local servers = {
            clangd = {
                cmd = { 'clangd' },
                root_markers = { '.clangd', 'compile_commands.json' },
                filetypes = { 'c', 'cpp', 'h', 'hpp' },
            },
            zls = {
                cmd = { 'zls' },
                filetypes = { 'zig' },
                settings = {
                    enable_autofix = false, -- Disable automatic fixes on save
                    warn_style = false,    -- Disable style warnings
                    enable_snippets = true, -- Optional: Enable snippets if desired
                }
            },
            gopls = {
                cmd = { 'gopls' },
                filetypes = {'go'},
            },
            lua_ls = {
                cmd = { 'lua-language-server' }, 
                filetypes = { 'lua' },
            },
        }

        for server, settings in pairs(servers) do
            vim.lsp.config(server, settings)
            vim.lsp.enable(server)
        end
    end
}
