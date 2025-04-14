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

            completion = { documentation = { auto_show = false } },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

        }
    },
    config = function()
        require("mason").setup()
        local servers = {
            clangd = {
                settings = {
                    cmd = { 'clangd' },
                    root_markers = { '.clangd', 'compile_commands.json' },
                    filetypes = { 'c', 'cpp' },
                }
            },
        }
        vim.lsp.config('clangd', {
            cmd = { 'clangd' },
            root_markers = { '.clangd', 'compile_commands.json' },
            filetypes = { 'c', 'cpp' },
        })
        vim.lsp.enable('clangd')

--      for server, settings in pairs(servers) do
--          vim.lsp.config(server, settings)
--          vim.lsp.enable(server)
--      end
    end
}
