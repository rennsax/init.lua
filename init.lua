vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

require "configs.options"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
}, require "plugins.configs.lazy")

vim.schedule(function()
  require "configs.mappings"
  require "configs.autocmds"
end)
