local ui_plugins = {
  {
    "lewis6991/gitsigns.nvim",
    enabled = not vim.g.vscode,
    opts = function ()
      return {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "󰍵" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "│" },
        },
      }
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
}

return ui_plugins
