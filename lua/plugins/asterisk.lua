return {
  "haya14busa/vim-asterisk",
  event = 'BufEnter',
  config = function()
    vim.keymap.set('', '*', '<Plug>(asterisk-*)')
    vim.keymap.set('', '#', '<Plug>(asterisk-#)')
    vim.keymap.set('', 'g*', '<Plug>(asterisk-g*)')
    vim.keymap.set('', 'g#', '<Plug>(asterisk-g#)')
    vim.keymap.set('', 'z*', '<Plug>(asterisk-z*)')
    vim.keymap.set('', 'gz*', '<Plug>(asterisk-gz*)')
    vim.keymap.set('', 'z#', '<Plug>(asterisk-z#)')
    vim.keymap.set('', 'gz#', '<Plug>(asterisk-gz#)')
  end
}
