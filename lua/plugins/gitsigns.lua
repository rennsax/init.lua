return {
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
}
