return {
  "nvim-tree/nvim-tree.lua",
  enabled = not vim.g.vscode,
  keys = {
    {"<D-b>", mode = {'n','i','v'}, "<Cmd>NvimTreeFocus<CR>", { desc = 'Toggle Nvim-tree' }},
    {"<Leader>b", mode = '', "<Cmd>NvimTreeFocus<CR>", { desc = 'Toggle Nvim-tree' }},
  },

  opts = function()
    return require("configs.nvim-tree")
  end
}
