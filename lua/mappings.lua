-- require "nvchad.mappings"

local map = vim.keymap.set

-- [[ Basic Keymaps ]]
--  See `:help keymap()`
--  By default, remap = false (i.e. Xnoremap)

map('i', 'jj', '<Esc>')
map('n', '<leader>n', '<cmd>nohl<CR>', { silent = true })
map('n', '<M-u>', '<cmd>nohl<CR>', { silent = true })
map('n', '<Up>', 'gk')
map('n', '<Down>', 'gj')
map('n', 'Y', '"+y')
map('x', 'Y', '"+y')
map('n', '<leader>p', '"*p')

-- <VIM> inoremap jj <Esc>
-- <VIM> nnoremap <silent> <Leader>n <cmd>nohl<CR>
-- <VIM> nnoremap <silent> <M-u> <cmd>nohl<CR>
-- <VIM> nnoremap <Up> gk
-- <VIM> nnoremap <Down> gj
-- <VIM> xnoremap Y "+y
-- <VIM> nnoremap Y "+y
-- <VIM> nnoremap <Leader>p "*p

-- Emac-like cursor move
map({'c', 'i'}, '<C-F>', '<Right>')
map({'c', 'i'}, '<C-B>', '<Left>')
map('c', '<C-a>', '<Home>')
map('c', '<C-e>', '<End>')
map('c', '<M-b>', '<S-Left>')
map('c', '<M-f>', '<S-Right>')
-- <VIM> cnoremap <C-A> <Home>
-- <VIM> cnoremap <C-E> <End>
-- <VIM> cnoremap <C-F> <Right>
-- <VIM> cnoremap <C-B> <Left>
-- <VIM> cnoremap <Esc>b <S-Left>
-- <VIM> cnoremap <Esc>f <S-Right>
-- <VIM> inoremap <C-b> <Left>
-- <VIM> inoremap <C-f> <Right>

--  See `:help wincmd` for a list of all window commands
--  Navigating between windows quickly, almost in every mode.
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')

map({'i','t','v'}, '<C-h>', '<C-\\><C-N><C-w>h')
map({'i','t','v'}, '<C-j>', '<C-\\><C-N><C-w>j')
map({'i','t','v'}, '<C-k>', '<C-\\><C-N><C-w>k')
map({'i','v'}, '<C-l>', '<C-\\><C-N><C-w>l') -- Do not map <C-L> in terminal-mode

-- <VIM> nnoremap <C-h> <C-w><C-h>
-- <VIM> nnoremap <C-l> <C-w><C-l>
-- <VIM> nnoremap <C-j> <C-w><C-j>
-- <VIM> nnoremap <C-k> <C-w><C-k>
-- <VIM> tnoremap <C-h> <C-\><C-N><C-w>h
-- <VIM> tnoremap <C-j> <C-\><C-N><C-w>j
-- <VIM> tnoremap <C-k> <C-\><C-N><C-w>k
-- <VIM> inoremap <C-h> <C-\><C-N><C-w>h
-- <VIM> inoremap <C-j> <C-\><C-N><C-w>j
-- <VIM> inoremap <C-k> <C-\><C-N><C-w>k
-- <VIM> inoremap <C-l> <C-\><C-N><C-w>l
-- <VIM> vnoremap <C-h> <C-\><C-N><C-w>h
-- <VIM> vnoremap <C-j> <C-\><C-N><C-w>j
-- <VIM> vnoremap <C-k> <C-\><C-N><C-w>k
-- <VIM> vnoremap <C-l> <C-\><C-N><C-w>l

-- [[ GUI-specified Keymaps ]]
-- These keymaps are only available when a GUI frontend is used.
-- On macOS, D=<Cmd>, M=Meta=<Alt>

map({'n','v','i'}, '<D-`>', '<C-\\><C-N><C-^>', { desc = "Edit previously edited file" })
map({'n','v','i'}, '<D-t>', '<Cmd>vs<CR>', { desc = "Split current window into two, vertically" })
map({'n','v','i'}, '<D-s>', '<Cmd>w<CR>', { desc = "Write buffer" })

-- [[ "THE BEST" Keymaps ]]
-- Originated from ThePrimeagen/init.lua

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "m'J`'")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>rn",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[R]ename [S]ymbol (globally)" })
