return {
  "hrsh7th/nvim-cmp",
  enabled = not vim.g.vscode,
  opts = function()
    return require "configs.cmp"
  end
}
