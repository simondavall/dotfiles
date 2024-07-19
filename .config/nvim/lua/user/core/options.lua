vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for better colorschemes to work
-- (have to use a true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorscheme that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- misc
opt.backup = false -- won't create a .bak file when saving a changed file
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (ms) E.g when pressing <leader>sv
opt.scrolloff = 8 -- number of lines always visible above and below when scrolling
opt.sidescrolloff = 8 -- number of columns always visible when scrolling



-- disable some default providers
vim.g["loaded_perl_provider"] = 0 -- disable perl as a language provider
vim.g["loaded_ruby_provider"] = 0 -- disable ruby as a language provider
