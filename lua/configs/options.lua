local g = vim.g
local o = vim.o
local opt = vim.opt

-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--  So leader is mapped in init.lua.
-- <VIM> let mapleader=" "
-- <VIM> let maplocalleader=" "

-- For lazy.nvim
g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt` and `:help option-list`

-- <VIM> set number relativenumber
opt.number = true
opt.relativenumber = true

-- Mouse mode is useful when resizing the windows.
-- <VIM> set mouse=
opt.mouse = 'a'

-- <VIM> set nosmd
opt.showmode = false

-- Persistent undoes
-- <VIM> set undofile
opt.undofile = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Display tab and trailing spaces specially
-- <VIM> set list
-- <VIM> set lcs="tab:» ,trail=·,nbsp=␣"
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- <VIM> set ignorecase smartcase
opt.ignorecase = true
opt.smartcase = true

-- How long (milliseconds) when a swap file will be written back to disk
-- <VIM> set updatetime=250
opt.updatetime = 250

-- Time in milliseconds to wait for a mapped sequence to complete.
-- For example, jj => <ESC>
-- <VIM> set timeoutlen=1000
opt.timeoutlen = 1000

-- Configure how new splits should be opened
-- <VIM> set splitright splitbelow
opt.splitright = true
opt.splitbelow = true

-- Preview substitutions live, as you type!
-- <VIM> set inccommand=split
opt.inccommand = 'split'

-- Show which line and column your cursor is on
-- <VIM> set cul
-- set cuc
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
-- <VIM> set scrolloff=6
opt.scrolloff = 6

-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- <VIM> set hlsearch
opt.hlsearch = true

-- Show matches while typing
-- <VIM> set incsearch
opt.incsearch = true

-- 24-bit RGB color
-- <VIM> set tgc
opt.termguicolors = true

-- Ignored when expanding |wildcards|
-- <VIM> set wildignore+=.pyc,.swp
opt.wildignore = ".pyc,.swp"

-- Affect terminal title
-- <VIM> set title
opt.title = true

-- <VIM> set nowrap
opt.wrap = false

-- Enable break indent
-- <VIM> set bri
opt.breakindent = true

-- A ruler at column 80
-- <VIM> set cc=80
opt.colorcolumn = '80'

-- Replace tab with spaces in insert mode
-- <VIM> set et
opt.expandtab = true

-- Round indent to multiple of |shiftwidth|
-- <VIM> set sr
opt.shiftround = true

-- Numbers of spaces to use for each step of (auto)indents.
-- Default 8, which is rarely used.
-- <VIM> set sw=4
opt.shiftwidth = 4

-- Number of spaces that a <Tab> in the file counts for.
-- Default 8, which is rarely used.
-- <VIM> set ts=4
opt.tabstop = 4

-- Number of spaces that a <Tab> counts for while performing editing operations
-- Default 0
-- <VIM> set sts=4
opt.softtabstop = 4

-- [[ Vim-compliant Options ]]
-- Options below are set by neovim by default, but kept for vim-compatiblity.

-- <VIM> set autoindent
-- <VIM> set smarttab
-- <VIM> syntax on

-- Instead of unloading buffers that are |abandon|ed, just hide them
-- <VIM> set hidden

-- Always display the status bar
-- <VIM> set laststatus=2

-- Automatically read file into buffer when the file is changed by others
-- <VIM> set autoread

