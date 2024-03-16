return {
  "hrsh7th/nvim-cmp",
  enabled = not vim.g.vscode,
  opts = function()
    require "configs.cmp"
  end
}
