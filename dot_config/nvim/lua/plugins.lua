-- Plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { -- colorscheme
        'w0ng/vim-hybrid',
        config = function()
            vim.cmd([[colorscheme hybrid]])
        end
    },
    { -- filer
        "lambdalisue/fern.vim",
        dependencies = {
            'lambdalisue/nerdfont.vim',
            'lambdalisue/fern-renderer-nerdfont.vim',
        },
        config = function()
            vim.g['fern#renderer'] = "nerdfont"
        end
    },
    { -- finder
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
            config = function()
                local telescope = require('telescope')
                local actions = require('telescope.actions')
                telescope.setup({
                    defaults = {
                        layout_config = {
                            prompt_position = "top",
                        },
                        sorting_strategy = "ascending",
                        path_display = {
                            "filename_first",
                        },
                        mappings = {
                            i = {
                                ["<C-j>"] = actions.move_selection_next,
                                ["<C-k>"] = actions.move_selection_previous,
                            },
                        },
                    }
                })

                telescope.load_extension "file_browser"
            end
        },
        {
            "nvim-telescope/telescope-file-browser.nvim",
            dependencies = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/plenary.nvim"
            }
        }
    },
    { -- lsp
        {
            'williamboman/mason.nvim',
            config = function()
                require('mason').setup()
            end
        },
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = {
                'williamboman/mason.nvim',
            },
            config = function()
                require('mason-lspconfig').setup({
                    ensure_installed = {
                        'gopls',
                        'volar',
                        'ts_ls',
                        'lua_ls',
                        'dockerls',
                        'docker_compose_language_service',
                        'html',
                    },
                    automatic_installation = true,
                })
            end
        },
        {
            'neovim/nvim-lspconfig',
            config = function()
                local lspconfig = require('lspconfig')
                lspconfig.gopls.setup {}
                lspconfig.volar.setup {
                    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                    init_options = {
                        vue = {
                            hybridMode = false,
                        },
                    },
                }
                lspconfig.lua_ls.setup {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                }
                lspconfig.dockerls.setup {}
                lspconfig.docker_compose_language_service.setup {}
                lspconfig.html.setup {}

                vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
                )
            end
        },
    },
    { -- completion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', keyword_length = 3 },
                    { name = 'vsnip',    keyword_length = 3 },
                    { name = 'buffer',   keyword_length = 3 },
                    { name = 'path',     keyword_length = 3 },
                    { name = "cody",     keyword_length = 3 },
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }),
            })
        end
    },
    { -- git
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require("gitsigns").setup()
            end
        },
        {
            'sindrets/diffview.nvim',
            config = function()
                require("diffview").setup()
            end
        }
    },
    { -- ai
        {
            'sourcegraph/sg.nvim',
            config = function()
                require("sg").setup()
            end
        },
        {
            "jackMort/ChatGPT.nvim",
            event = "VeryLazy",
            dependencies = {
                "MunifTanjim/nui.nvim",
                "nvim-lua/plenary.nvim",
                "folke/trouble.nvim",
                "nvim-telescope/telescope.nvim"
            },
            config = function()
                require("chatgpt").setup({
                    api_key_cmd = "op read op://Employee/OPENAI_API_KEY/credential",
                })
            end,
        }
    },
    { -- markdown
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('render-markdown').setup({
                render_modes = true,
                heading = {
                    width = "block",
                    left_pad = 0,
                    right_pad = 4,
                    icons = {},
                },
                code = {
                    width = "block",
                    right_pad = 4,
                },
            })
        end
    },
    { -- golang
        'mattn/vim-goimports',
        config = function()
            vim.g['goimports'] = true
        end
    },
    { -- status line
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = ' ', right = ' ' },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                            file_status = true,
                            shorting_target = 40,
                        },
                        {
                            'diagnostics',
                            sources = { 'nvim_lsp' },
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                            always_visible = false,
                        },
                    },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
            })
        end
    }
})
