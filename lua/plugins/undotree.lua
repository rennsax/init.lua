return {
  "mbbill/undotree",
  event = "BufEnter",
  config = function()
    vim.g.undotree_WindowLayout = 3
    vim.keymap.set('n', '<Leader>u', vim.cmd.UndotreeToggle, {
      desc = "Toggle Undotree"
    })
  end
}
