-- Auto Commands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('MyAutoCmd', { clear = true })

autocmd('FileType', {
    group = 'MyAutoCmd',
    pattern = '*',
    callback = function()
        vim.cmd([[NoMatchParen]]) -- Disable matchparen
    end,
})

autocmd('BufWritePre', {
    group = 'MyAutoCmd',
    pattern = '*',
    callback = function()
        vim.cmd([[%s/\s\+$//e]])              -- Automatically remove trailing whitespace
        vim.cmd([[lua vim.lsp.buf.format()]]) -- format by lsp
    end,
})

autocmd('TermOpen', {
    group = 'MyAutoCmd',
    pattern = '*',
    callback = function()
        vim.cmd([[
            setlocal norelativenumber
            setlocal nonumber
            startinsert
        ]]) -- Automatically enter insert mode in terminal
    end,
})
