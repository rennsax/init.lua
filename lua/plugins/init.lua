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

  -- ui
  {
    "NvChad/base46",
    enabled = not vim.g.vscode,
  },

  {
    "NvChad/ui",
    enabled = not vim.g.vscode,
  },

  {
    "NvChad/nvim-colorizer.lua",
    enabled = not vim.g.vscode,
  },

  {
    "nvim-tree/nvim-web-devicons",
    enabled = not vim.g.vscode,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = not vim.g.vscode,
  },

  {
    "folke/which-key.nvim",
    enabled = not vim.g.vscode,
  }

}
