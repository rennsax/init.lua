vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true -- For lazy.nvim

require "configs.options"

require "configs.lazy"

vim.schedule(function()
  require "configs.mappings"
  require "configs.autocmds"
end)

