-- Basic Settings
-- General settings
vim.opt.number = true        -- Show line numbers
vim.opt.signcolumn = 'yes'   -- Show the sign column to display markers like git blame, diagnostics, etc.
vim.opt.wrap = true          -- Enable line wrapping
vim.opt.linebreak = true     -- Enable linebreak
vim.opt.scrolloff = 8        -- Keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 8    -- Keep 8 columns visible when scrolling horizontally
vim.opt.termguicolors = true -- Enable 24-bit RGB colors

-- Highlighting matching parens
vim.g.loaded_matchparen = true
vim.g.matchparen_disable_cursor_hl = true

-- Tab and indentation settings
vim.opt.tabstop = 4        -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4     -- Number of spaces for each indentation
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.autoindent = true  -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Smart indentation based on syntax

-- Search settings
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override 'ignorecase' if pattern contains uppercase
vim.opt.incsearch = true  -- Show matches as you type
vim.opt.hlsearch = true   -- Highlight search matches

-- Backup and swap settings
vim.opt.backup = false      -- Disable backup files
vim.opt.writebackup = false -- Disable write backup files
vim.opt.swapfile = false    -- Disable swap files

-- Clipboard
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

-- Performance
vim.opt.updatetime = 300 -- Faster completion (default is 4000ms)
vim.opt.timeoutlen = 500 -- Time to wait for a mapped sequence to complete (ms)

-- Split windows
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

-- Mouse and cursor
vim.opt.mouse = 'a'        -- Enable mouse support in all modes
vim.opt.cursorline = false -- Disable highlighting of the current line

-- Encoding settings
vim.opt.encoding = 'utf-8'     -- Set internal encoding to UTF-8
vim.opt.fileencoding = 'utf-8' -- Set file encoding to UTF-8

-- Show special characters
vim.opt.list = true -- Enable display of special characters
vim.opt.listchars = {
    tab = '>.',     -- Represent tabs with '>.'
    trail = '_',    -- Represent trailing spaces with '_'
    extends = '>',  -- Represent lines that extend beyond the window with '>'
    precedes = '<', -- Represent lines that precede the window with '<'
    nbsp = '%',     -- Represent non-breaking spaces with '%'
}

-- buffer
vim.opt.hidden = true  -- Allows you to switch between buffers without saving
vim.opt.confirm = true -- Confirm before performing certain potentially destructive operations,

-- diagnostic
vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
        end,
    },
})
