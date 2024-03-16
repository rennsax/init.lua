return {
  "mbbill/undotree",
  keys = {
    {"<Leader>u", mode = "n", function() vim.cmd.UndotreeToggle() end, { desc = "Toggle Undotree" }}
  },
  config = function()
    vim.g.undotree_WindowLayout = 3
  end
}
