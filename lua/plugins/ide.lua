if vim.g.vscode then
  return {}
end

return {

  {
    'Exafunction/codeium.vim',
    enabled = false,
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set('i', '<C-i>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })

      vim.g.codeium_enabled = false
    end
  },

  {
    "mbbill/undotree",
    keys = {
      {"<Leader>u", mode = "n", function() vim.cmd.UndotreeToggle() end, desc = "Toggle Undotree" }
    },
    init = function()
      vim.g.undotree_WindowLayout = 3
    end
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    'wakatime/vim-wakatime',
    event = "VeryLazy"
  },

}
