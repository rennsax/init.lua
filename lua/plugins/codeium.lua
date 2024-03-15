return {
  'Exafunction/codeium.vim',
  enabled = not vim.g.vscode,
  event = 'BufEnter',
  config = function()
    vim.g.codeium_disable_bindings = 1
    vim.keymap.set('i', '<C-i>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true })

    vim.g.codeium_enabled = false
  end
}
