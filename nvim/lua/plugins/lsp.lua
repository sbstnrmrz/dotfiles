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
                filetypes = { 'c', 'cpp', 'h', 'hpp' },
                root_markers = { '.clangd', 'compile_commands.json' },
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
            pyright = {
                cmd = { 'pyright-langserver', '--stdio' },
                filetypes = { 'python' },
                root_markers = {
                    'pyproject.toml',
                    'setup.py',
                    'setup.cfg',
                    'requirements.txt',
                    'Pipfile',
                    'pyrightconfig.json',
                    '.git',
                },
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = 'openFilesOnly',
                        },
                    },
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
            html_lsp = {
                cmd = { 'vscode-html-language-server', '--stdio'},
                filetypes = {'html'},
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = {
                        css = true,
                        javascript = true,
                    },
                    provideFormatter = true,
                },
            },
            css_ls = {
                cmd = { 'vscode-css-language-server', '--stdio' },
                filetypes = { 'css', 'scss', 'less' },
                init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
                root_markers = { 'package.json', '.git' },
                settings = {
                    css = { validate = true },
                    scss = { validate = true },
                    less = { validate = true },
                },
            },

            ts_ls = {
                init_options = { 
                    hostInfo = 'neovim', 
                    plugins = {
                        {
                        name = '@vue/typescript-plugin',
                        location = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                        languages = { 'vue' },
                        configNamespace = 'typescript',
                        }
                    },
                },
                cmd = { 'typescript-language-server', '--stdio' },
                filetypes = {
                    'javascript',
                    'javascriptreact',
                    'javascript.jsx',
                    'typescript',
                    'typescriptreact',
                    'typescript.tsx',
                    'vue',
                },
                root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
                handlers = {
                    -- handle rename request for certain code actions like extracting functions / types
                    ['_typescript.rename'] = function(_, result, ctx)
                        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
                        vim.lsp.util.show_document({
                            uri = result.textDocument.uri,
                            range = {
                                start = result.position,
                                ['end'] = result.position,
                            },
                        }, client.offset_encoding)
                        vim.lsp.buf.rename()
                        return vim.NIL
                    end,
                },
                commands = {
                    ['editor.action.showReferences'] = function(command, ctx)
                        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
                        local file_uri, position, references = unpack(command.arguments)

                        local quickfix_items = vim.lsp.util.locations_to_items(references, client.offset_encoding)
                        vim.fn.setqflist({}, ' ', {
                            title = command.title,
                            items = quickfix_items,
                            context = {
                                command = command,
                                bufnr = ctx.bufnr,
                            },
                        })

                        vim.lsp.util.show_document({
                            uri = file_uri,
                            range = {
                                start = position,
                                ['end'] = position,
                            },
                        }, client.offset_encoding)

                        vim.cmd('botright copen')
                    end,
                },
                on_attach = function(client, bufnr)
                    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
                    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
                    vim.api.nvim_buf_create_user_command(bufnr, 'LspTypescriptSourceAction', function()
                        local source_actions = vim.tbl_filter(function(action)
                            return vim.startswith(action, 'source.')
                        end, client.server_capabilities.codeActionProvider.codeActionKinds)

                        vim.lsp.buf.code_action({
                            context = {
                                only = source_actions,
                            },
                        })
                    end, {})
                end,
            },
            sqls = {
                cmd = {'sqls'},
                filetypes = {'sql', 'mysql'},
                root_markers = {'.sqllsrc.json'},
            },
            astro_ls = {
                cmd = {"astro-ls", "--stdio" },
                filetypes = {'astro'},
                root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
                init_options = {typescript = {tsdk = 'node_modules/typescript/lib'}},
            },
            emmet_ls = {
                cmd = { 'emmet-language-server', '--stdio' },
                filetypes = {
                    'astro',
                    'css',
                    'eruby',
                    'html',
                    'htmlangular',
                    'htmldjango',
                    'javascriptreact',
                    'less',
                    'pug',
                    'sass',
                    'scss',
                    'svelte',
                    'templ',
                    'typescriptreact',
                },
                root_markers = { '.git' },
            },
                
--          vtsls = {
--              cmd = { 'vtsls', '--stdio' },
--              filetypes = {
--                  'javascript',
--                  'javascriptreact',
--                  'javascript.jsx',
--                  'typescript',
--                  'typescriptreact',
--                  'typescript.tsx',
--                  'vue',
--              },
--              root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
--          },
            tailwind_ls = {
                cmd = { 'tailwindcss-language-server', '--stdio' },
                -- filetypes copied and adjusted from tailwindcss-intellisense
                filetypes = {
                    -- html
                    'aspnetcorerazor',
                    'astro',
                    'astro-markdown',
                    'blade',
                    'clojure',
                    'django-html',
                    'htmldjango',
                    'edge',
                    'eelixir', -- vim ft
                    'elixir',
                    'ejs',
                    'erb',
                    'eruby', -- vim ft
                    'gohtml',
                    'gohtmltmpl',
                    'haml',
                    'handlebars',
                    'hbs',
                    'html',
                    'htmlangular',
                    'html-eex',
                    'heex',
                    'jade',
                    'leaf',
                    'liquid',
                    'markdown',
                    'mdx',
                    'mustache',
                    'njk',
                    'nunjucks',
                    'php',
                    'razor',
                    'slim',
                    'twig',
                    -- css
                    'css',
                    'less',
                    'postcss',
                    'sass',
                    'scss',
                    'stylus',
                    'sugarss',
                    -- js
                    'javascript',
                    'javascriptreact',
                    'reason',
                    'rescript',
                    'typescript',
                    'typescriptreact',
                    -- mixed
                    'vue',
                    'svelte',
                    'templ',
                },
                settings = {
                    tailwindCSS = {
                        validate = true,
                        lint = {
                            cssConflict = 'warning',
                            invalidApply = 'error',
                            invalidScreen = 'error',
                            invalidVariant = 'error',
                            invalidConfigPath = 'error',
                            invalidTailwindDirective = 'error',
                            recommendedVariantOrder = 'warning',
                        },
                        classAttributes = {
                            'class',
                            'className',
                            'class:list',
                            'classList',
                            'ngClass',
                        },
                        includeLanguages = {
                            eelixir = 'html-eex',
                            elixir = 'phoenix-heex',
                            eruby = 'erb',
                            heex = 'phoenix-heex',
                            htmlangular = 'html',
                            templ = 'html',
                        },
                    },
                },
                before_init = function(_, config)
                    if not config.settings then
                        config.settings = {}
                    end
                    if not config.settings.editor then
                        config.settings.editor = {}
                    end
                    if not config.settings.editor.tabSize then
                        config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
                    end
                end,
                workspace_required = true,
                root_dir = function(bufnr, on_dir)
                    local root_files = {
                        -- Generic
                        'tailwind.config.js',
                        'tailwind.config.cjs',
                        'tailwind.config.mjs',
                        'tailwind.config.ts',
                        'postcss.config.js',
                        'postcss.config.cjs',
                        'postcss.config.mjs',
                        'postcss.config.ts',
                        -- Django
                        'theme/static_src/tailwind.config.js',
                        'theme/static_src/tailwind.config.cjs',
                        'theme/static_src/tailwind.config.mjs',
                        'theme/static_src/tailwind.config.ts',
                        'theme/static_src/postcss.config.js',
                        -- Fallback for tailwind v4, where tailwind.config.* is not required anymore
                        '.git',
                        'package.json',
                        'mix.lock'
                    }
                    local fname = vim.api.nvim_buf_get_name(bufnr)
                    on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
                end,
            },

            vue_ls = {
                cmd = { 'vue-language-server', '--stdio' },
                filetypes = { 'vue' },
                root_markers = { 'package.json' },
                on_init = function(client)
                    client.handlers['tsserver/request'] = function(_, result, context)
                        local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
                        local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
                        local clients = {}

                        vim.list_extend(clients, ts_clients)
                        vim.list_extend(clients, vtsls_clients)

                        if #clients == 0 then
                            vim.notify('Could not find `ts_ls` or `vtsls` lsp client, required by `vue_ls`.', vim.log.levels.ERROR)
                            return
                        end
                        local ts_client = clients[1]

                        local param = unpack(result)
                        local id, command, payload = unpack(param)
                        ts_client:exec_cmd({
                            title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
                            command = 'typescript.tsserverRequest',
                            arguments = {
                                command,
                                payload,
                            },
                        }, { bufnr = context.bufnr }, function(_, r)
                                local response_data = { { id, r and r.body } }
                                ---@diagnostic disable-next-line: param-type-mismatch
                                client:notify('tsserver/response', response_data)
                            end)
                    end
                end,
            },
            prisma_ls = {
                cmd = { 'prisma-language-server', '--stdio' },
                filetypes = { 'prisma' },
                settings = {
                    prisma = {
                        prismaFmtBinPath = '',
                    },
                },
                root_markers = { '.git', 'package.json' },
            }
        }

        for server, settings in pairs(servers) do
            vim.lsp.config(server, settings)
            vim.lsp.enable(server)
        end


    end
}
