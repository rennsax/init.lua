if not vim.g.vscode then
  return {}
end

local enabled = {
  "flash.nvim",
  "Comment.nvim",
  "nvim-surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "vim-asterisk",
  "ReplaceWithRegister",
  "lazy.nvim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

local api = require("vscode-neovim")
local api_call = function(cmd)
  return function()
    api.call(cmd)
  end
end
local map = vim.keymap.set

map("n", "<leader>sf", "<cmd>Find<cr>")
map("n", "<leader>rg", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
-- vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
-- Workaround for gk/gj
-- See https://github.com/vscode-neovim/vscode-neovim/blob/68f056b4c9cb6b2559baa917f8c02166abd86f11/vim/vscode-code-actions.vim#L93-L95
map("n", "<Up>", "gk", {remap = true})
map("n", "<Down>", "gj", {remap = true})
-- show hover
-- map(
--   "n", "<Leader>vh", "<cmd>lua require('vscode-neovim').call('editor.action.showHover')<CR>")
map("n", "<Leader>h", api_call("editor.action.showHover"))
-- code refactor
map("n", "<Leader>vcr", api_call("editor.action.refactor"))

map("n", "<Leader>vo", api_call("clangd.switchheadersource"))
-- update tag
map("n", "<Leader>vut", api_call("editor.emmet.action.updateTag"))
-- show definition
map("n", "<Leader>vsd", api_call("editor.action.peekDefinition"))
-- show reference
map("n", "<Leader>vsr", api_call("editor.action.referenceSearch.trigger"))
-- toggle dash
map("n", "<Leader>v<C-h>", api_call("extension.dash.specific"))
-- toggle bookmark
map("n", "<Leader>vm", api_call("bookmarks.toggle"))
-- open file manage
map("n", "<Leader>vf", api_call("workbench.explorer.fileView.focus"))
-- restart neovim
map("n", "<Leader>vrn", api_call("vscode-neovim.restart"))

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
