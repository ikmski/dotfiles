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
        {
            "lambdalisue/fern.vim",
            dependencies = {
                'lambdalisue/nerdfont.vim',
                'lambdalisue/fern-renderer-nerdfont.vim',
            },
            config = function()
                vim.g['fern#renderer'] = "nerdfont"
            end
        },
        {
            'stevearc/oil.nvim',
            dependencies = {
                "nvim-mini/mini.icons",
            },
            lazy = false,
            config = function()
                require("oil").setup({
                    watch_for_changes = true,
                    keymaps = {
                        ["?"] = { mode = "n", "actions.show_help" },
                        ["<C-h>"] = { mode = "n", "actions.parent" },
                        ["<C-l>"] = { mode = "n", "actions.select" },
                        ["<CR>"] = { mode = "n", "actions.select" },
                        ["<C-p>"] = { mode = "n", "actions.preview" },
                        ["*"] = { mode = "n", "actions.toggle_hidden" },
                    },
                    use_default_keymaps = false,
                    view_options = {
                        show_hidden = true,
                    },
                })
            end
        },
    },
    { -- finder
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-treesitter/nvim-treesitter',
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
                        'vue_ls',
                        'vtsls',
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
        },
        {
            'f-person/git-blame.nvim',
            event = 'VeryLazy',
            config = function()
                require('gitblame').setup {
                    enabled = false,
                }
            end
        }
    },
    { -- ai
    },
    { -- markdown
        {
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
        {
            "iamcco/markdown-preview.nvim",
            event = 'VeryLazy',
            filetypes = { "markdown" },
            build = function()
                vim.fn["mkdp#util#install"]()
            end,
        },
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
    },
    { -- UI
        {
            "shellRaining/hlchunk.nvim",
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                require("hlchunk").setup({
                    chunk = {
                        enable = true
                    },
                })
            end
        },
    }
})
