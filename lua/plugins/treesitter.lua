return {
  "nvim-treesitter/nvim-treesitter",
  enabled = not vim.g.vscode,
  opts = {
    -- ensure_installed = { "lua", "vim", "vimdoc" },

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = { enable = true },
  },
}

