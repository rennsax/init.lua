local map = vim.keymap.set

local mac_cmd_map = function(lhs, rhs, opts)
  map({"n","i","v"}, lhs, rhs, opts)
end

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
map({'n', 'v'}, '<Leader>d', '"_d', { desc = "Delete with the black hole register" })
map('n', 'q:', '<Nop>')

-- Quickly resize the window size
-- Ref: https://vim.fandom.com/wiki/Fast_window_resizing_with_plus/minus_keys
-- TODO: support v:count
map('n', '+', '<c-w>>')
map('n', '-', '<c-w><')
-- map('n', '-', function () return '<c-w>' .. vim.v.count .. '<' end, { expr = true })
map('n', 'g+', [[<cmd>exe "vert resize " . (winwidth(0)*3/2)<CR>]], {
  silent = true,
  desc = "Increase win height to 1.5x",
})
map('n', 'g-', [[<cmd>exe "vert resize " . (winwidth(0)*2/3)<CR>]], {
  silent = true,
  desc = "Decrease win height to 0.67x",
})

-- <VIM> inoremap jj <Esc>
-- <VIM> nnoremap <silent> <Leader>n <cmd>nohl<CR>
-- <VIM> nnoremap <silent> <M-u> <cmd>nohl<CR>
-- <VIM> nnoremap <Up> gk
-- <VIM> nnoremap <Down> gj
-- <VIM> xnoremap Y "+y
-- <VIM> nnoremap Y "+y
-- <VIM> nnoremap <Leader>p "*p
-- <VIM> nnoremap <Leader>d "_d
-- <VIM> vnoremap <Leader>d "_d
-- <VIM> nnoremap q: <Nop>
-- <VIM> nnoremap + <c-w>+
-- <VIM> nnoremap - <c-w>-
-- <VIM> nnoremap <silent> g+ :exe "resize " . (winheight(0) * 3/2)<CR>
-- <VIM> nnoremap <silent> g- :exe "resize " . (winheight(0) * 2/3)<CR>

-- Emac-like cursor move
map({'c', 'i'}, '<c-f>', '<Right>')
map({'c', 'i'}, '<c-b>', '<Left>')
map({'c', 'i'}, '<c-a>', '<Home>')
map({'c', 'i'}, '<c-e>', '<End>')
map({'c', 'i'}, '<m-b>', '<S-Left>')
map({'c', 'i'}, '<m-f>', '<S-Right>')

-- <VIM> cnoremap <c-a> <Home>
-- <VIM> cnoremap <c-e> <End>
-- <VIM> cnoremap <c-b> <Left>
-- <VIM> cnoremap <c-f> <Right>
-- <VIM> cnoremap <m-b> <S-Left>
-- <VIM> cnoremap <m-f> <S-Right>
-- <VIM> inoremap <c-a> <Home>
-- <VIM> inoremap <c-e> <End>
-- <VIM> inoremap <c-b> <Left>
-- <VIM> inoremap <c-f> <Right>
-- <VIM> inoremap <m-b> <S-Left>
-- <VIM> inoremap <m-f> <S-Right>

-- [[ "THE BEST" Keymaps ]]
-- Originated from ThePrimeagen/init.lua

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "m'J`'")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

-- <VIM> nnoremap <C-d> <C-d>zz
-- <VIM> nnoremap <C-u> <C-u>zz
-- <VIM> nnoremap <C-f> <C-f>zz
-- <VIM> nnoremap <C-b> <C-b>zz

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- <VIM> nnoremap n nzzzv
-- <VIM> nnoremap N Nzzzv

map("n", "<leader>rn",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[R]ename [S]ymbol (globally)" })

-- [[ GUI-specified Keymaps ]]
-- These keymaps are only available when a GUI frontend is used.
-- On macOS, D=<Cmd>, M=Meta=<Alt>

mac_cmd_map('<D-`>', '<C-\\><C-N><C-^>', { desc = "Edit previously edited file" })
mac_cmd_map('<D-s>', '<Cmd>w<CR>', { desc = "Write buffer" })
mac_cmd_map('<D-v>', '<Esc>"*pa', { desc = "Paste from system clipborad" })


if not vim.g.vscode then
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

end

