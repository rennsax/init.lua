return {
  "iamcco/markdown-preview.nvim",
  enabled = not vim.g.vscode,
  event = "BufEnter *.md",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
