local ui_plugins = {
  {
    "lewis6991/gitsigns.nvim",
    enabled = not vim.g.vscode,

    opts = function ()
      return require("plugins.configs.gitsigns")
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = not vim.g.vscode,
    keys = {
      {"<D-b>", mode = {'n','i','v'}, "<Cmd>NvimTreeFocus<CR>", { desc = 'Toggle Nvim-tree' }},
      {"<Leader>b", mode = '', "<Cmd>NvimTreeFocus<CR>", { desc = 'Toggle Nvim-tree' }},
    },

    opts = function()
      return require("plugins.configs.nvim-tree")
    end
  },

  {
    "rebelot/kanagawa.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    opts = {
      -- Remove the background of LineNr, {Sign,Fold}Column and friends
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      }
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd "colorscheme kanagawa"
    end
  },

}

return ui_plugins
