-- Disable some defaults
return {
  {
    "williamboman/mason.nvim",
    enabled = false
  },

  {
    "neovim/nvim-lspconfig",
    enabled = false
  },

  {
    "nvim-tree/nvim-web-devicons",
    enabled = not vim.g.vscode,
  },

  {
    "folke/which-key.nvim",
    enabled = not vim.g.vscode,
  }

}
