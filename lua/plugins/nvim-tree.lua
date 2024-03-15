return {
  "nvim-tree/nvim-tree.lua",
  enabled = vim.g.vscode,
  version = "*",
  lazy = false,
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      enabled = vim.g.have_nerd_font
    }
  },
  config = function()
    require("nvim-tree").setup {
      -- The cursor is always at the beginning.
      hijack_cursor = true,
      sync_root_with_cwd= true,
      filters = {
        -- To toggle dotfiles temporarily, type H
        dotfiles = true
      },
    }
    local api = require("nvim-tree.api")

    vim.cmd('cnoreabbrev Ex NvimTreeOpen')
    vim.keymap.set({'n','i','v'}, '<D-b>', api.tree.focus, { desc = 'Toggle Nvim-tree' })
    vim.keymap.set('', '<Leader>b', api.tree.focus, { desc = 'Toggle Nvim-tree' })
  end,
}
