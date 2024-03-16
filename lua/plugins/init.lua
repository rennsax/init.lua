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
    "lewis6991/gitsigns.nvim",
    enabled = not vim.g.vscode,
    opts = function()
      require "configs.gitsigns"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    enabled = not vim.g.vscode,
    opts = function()
      require "configs.cmp"
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    enabled = not vim.g.vscode,
    config = function()
      require "configs.treesitter"
    end,
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
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = not vim.g.vscode,
    keys = {"<D-b>", "<Leader>b"},
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
      local api = require("nvim-tree.api")

      vim.cmd('cnoreabbrev Ex NvimTreeOpen')
      vim.keymap.set({'n','i','v'}, '<D-b>', "<Cmd>NvimTreeFocus<CR>", { desc = 'Toggle Nvim-tree' })
      vim.keymap.set('', '<Leader>b', "<Cmd>NvimTreeFocus<CR>", { desc = 'Toggle Nvim-tree' })
    end,
  },

}
