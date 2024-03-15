return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup()
    vim.cmd [[
      " set
      autocmd TermEnter term://*toggleterm#*
        \ tnoremap <silent><D-j> <Cmd>exe v:count1 . "ToggleTerm"<CR>

      " By applying the mappings this way you can pass a count to your
      " mapping to open a specific window.
      " For example: 2<C-t> will open terminal 2
      nnoremap <silent><D-j> <Cmd>exe v:count1 . "ToggleTerm"<CR>
      inoremap <silent><D-j> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
      nnoremap <silent><Leader>t <Cmd>exe v:count1 . "ToggleTerm"<CR>
    ]]

  end,
  event = "VeryLazy",
}
