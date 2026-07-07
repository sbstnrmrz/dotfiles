vim.pack.add({
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/rafamadriz/friendly-snippets',
    { src = 'https://github.com/saghen/blink.cmp', version = 'v1.10.2'},
})

vim.cmd.packadd('nvim.undotree')

require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})



require("oil").setup()

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        --              component_separators = { left = '', right = ''},
        --              section_separators = { left = '', right = ''},
        component_separators = { left = '│', right = '│'},
        section_separators = { left = ' ', right = ' '},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})

require("telescope").setup({
    defaults = {
        mappings = {
            n = {
--               ["<leader>ff"] = "find_files",
--               ["<leader>fg"] = "live_grep",
--               ["<leader>fb"] = "buffers",
--               ["<leader>fh"] = "help_tags",
--               ["<leader>fc"] = "commands",

            },
            i = {
                ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {
    },
    extensions = {}
})

require('nvim-treesitter').install{'c', 'javascript', 'lua', 'go', 'vim', 'typescript', 'vue', 'astro'}

vim.lsp.config('ts_ls', {
    init_options = { 
        hostInfo = 'neovim', 
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = vim.fn.stdpath('data') .. "~/.nvm/versions/node/v24.14.1/lib/node_modules/@vue/typescript-plugin/",
                languages = { 'vue' },
                configNamespace = 'typescript',
            }
        },
    },
})

vim.lsp.config('astro', {
    init_options = {
        typescript = {
            tsdk = '/usr/local/lib/node_modules/typescript/lib'
        },
    }
})


vim.lsp.enable({'ts_ls', 'clangd', 'vue_ls', 'gopls', 'tailwindcss', 'emmet_language_server', 'astro', 'basedpyright', 'pyrefly', 'zls'})

require('blink.cmp').setup({
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },

    completion = { documentation = { auto_show = true } },

    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }},

    fuzzy = { implementation = "prefer_rust_with_warning" }
})

