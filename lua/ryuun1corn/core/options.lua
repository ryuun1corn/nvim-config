vim.cmd("let g:netrw_liststyle = 3")

-- for conciseness
local opt = vim.opt

-- line numbering
opt.relativenumber = true
opt.number = true

-- tabs & indentation 
opt.tabstop = 2 -- 2 spaces for tab (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one

opt.wrap = false

--search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- assume case sensitive when including mixed case in search

opt.cursorline = true

--turn on termguicolors
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

