vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

vim.keymap.set("i", "<a-[>", ",<left><c-\\>{", {
  remap = true, desc = [[Insert "{\\n\\n}",]], buffer = true
})
