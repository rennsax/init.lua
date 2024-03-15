return  {
  "lewis6991/gitsigns.nvim",
  event = "User FilePost",
  opts = function()
    local opts = require "nvchad.configs.gitsigns"
    opts.on_attach = nil
    return opts
  end,
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "git")
    require("gitsigns").setup(opts)
  end,
}
