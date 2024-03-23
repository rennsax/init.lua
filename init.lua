vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "configs.options"

require "configs.lazy"

vim.schedule(function()
  require "configs.mappings"
  require "configs.autocmds"
end)

