if not vim.g.vscode then
  return
end
-- Workaround for gk/gj
-- See https://github.com/vscode-neovim/vscode-neovim/blob/68f056b4c9cb6b2559baa917f8c02166abd86f11/vim/vscode-code-actions.vim#L93-L95
vim.keymap.set("n", "<Up>", "gk", {remap = true})
vim.keymap.set("n", "<Down>", "gj", {remap = true})
-- show hover
vim.keymap.set(
  "n", "<Leader>vh", "<cmd>lua require('vscode-neovim').call('editor.action.showHover')<CR>")
-- code refactor
vim.keymap.set(
  "n", "<Leader>vcr", "<cmd>lua require('vscode-neovim').call('editor.action.refactor')<CR>")

vim.keymap.set(
  "n", "<Leader>vo", "<cmd>lua require('vscode-neovim').call('clangd.switchheadersource')<CR>")
-- update tag
vim.keymap.set(
  "n", "<Leader>vut", "<cmd>lua require('vscode-neovim').call('editor.emmet.action.updateTag')<CR>")
-- show definition
vim.keymap.set(
  "n", "<Leader>vsd", "<cmd>lua require('vscode-neovim').call('editor.action.peekDefinition')<CR>")
-- show reference
vim.keymap.set(
  "n", "<Leader>vsr", "<cmd>lua require('vscode-neovim').call('editor.action.referenceSearch.trigger')<CR>")
-- toggle dash
vim.keymap.set(
  "n", "<Leader>v<C-h>", "<cmd>lua require('vscode-neovim').call('extension.dash.specific')<CR>")
-- toggle bookmark
vim.keymap.set(
  "n", "<Leader>vm", "<cmd>lua require('vscode-neovim').call('bookmarks.toggle')<CR>")
-- open file manage
vim.keymap.set(
  "n", "<Leader>vf", "<cmd>lua require('vscode-neovim').call('workbench.explorer.fileView.focus')<CR>")
-- restart neovim
vim.keymap.set(
  "n", "<Leader>vrn", "<cmd>lua require('vscode-neovim').call('vscode-neovim.restart')<CR>")
