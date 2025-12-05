-- Keymaps
-- Automatically insert closing brackets
vim.keymap.set('i', '{<Enter>', '{}<Left><CR><ESC><S-o>')
vim.keymap.set('i', '[<Enter>', '[]<Left><CR><ESC><S-o>')
vim.keymap.set('i', '(<Enter>', '()<Left><CR><ESC><S-o>')

vim.keymap.set('i', '\'', '\'\'<LEFT>')
vim.keymap.set('i', '\"', '\"\"<LEFT>')

-- Move buffer
vim.keymap.set('n', 'bp', '<cmd>bprevious<CR>', { silent = true }) -- Open the previous buffer
vim.keymap.set('n', 'bn', '<cmd>bnext<CR>', { silent = true })     -- Open the next buffer

-- When jumping to tags, if there are multiple options, display a list
vim.keymap.set('n', '<C-]', 'g<C-]')

-- Launch terminal mode with bottom split
vim.keymap.set('n', 'tt', '<cmd>belowright new<CR><cmd>terminal<CR>', { silent = true })

-- filer
--vim.keymap.set('n', ',fi', '<cmd>Fern . -reveal=% -wait<CR>', { silent = true })
--vim.keymap.set('n', ',fc', '<cmd>Fern %:h -reveal=% -wait<CR>', { silent = true })
vim.keymap.set('n', ',fi', '<cmd>Oil<CR>', { silent = true })
vim.keymap.set('n', ',fc', function()
    local cwd = vim.fn.getcwd()
    require("oil").open(cwd)
end, { silent = true })

-- finder
local builtin = require('telescope.builtin')
vim.keymap.set('n', ',ff', builtin.find_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', ',fu', builtin.oldfiles, { desc = 'Telescope oldfiles' })
vim.keymap.set('n', ',fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', ',fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', ',fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', ',fo', builtin.treesitter, { desc = 'Telescope outlines' })
vim.keymap.set("n", ',fj', '<cmd>Telescope file_browser<CR>')

-- lsp
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
