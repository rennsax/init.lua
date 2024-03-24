if not vim.g.neovide then
  return {}
end

local o = vim.o
local g = vim.g
local map = vim.keymap.set

local mac_cmd_map = function(lhs, rhs, opts)
  map({"n","i","v"}, lhs, rhs, opts)
end

g._guifont_size = 14 -- The default font size
g._guifont_family = "MonaspiceRn Nerd Font"

local function gen_guifont(font_family, font_size)
  return string.format("%s:h%d", font_family, font_size)
end
o.guifont = gen_guifont(g._guifont_family, g._guifont_size)

g.neovide_input_macos_alt_is_meta = true
g.neovide_padding_top = 10
g.neovide_padding_bottom = 10
g.neovide_padding_right = 10
g.neovide_padding_left = 10
g.neovide_window_blurred = true
g.neovide_transparency = 0.96
g.neovide_hide_mouse_when_typing = true

-- [[ GUI-specified Keymaps ]]
-- These keymaps are only available when a GUI frontend is used.
-- On macOS, D=<Cmd>, M=Meta=<Alt>

mac_cmd_map('<D-`>', '<C-\\><C-N><C-^>', { desc = "Edit previously edited file" })
mac_cmd_map('<D-s>', '<Cmd>w<CR>', { desc = "Write buffer" })
mac_cmd_map('<D-v>', '<Esc>"*pa', { desc = "Paste from system clipborad" })
mac_cmd_map('<D-+>', function()
  g._guifont_size = g._guifont_size + 2
  o.guifont = gen_guifont(g._guifont_family, g._guifont_size)
end, { desc = "zoom in" })
mac_cmd_map('<D-_>', function()
  g._guifont_size = g._guifont_size - 2
  o.guifont = gen_guifont(g._guifont_family, g._guifont_size)
end, { desc = "zoom out" })
mac_cmd_map('<D-w>', '<leader>x', { remap = true })

-- Auto-disable IME (input method) when entering insert mode
local function set_ime(args)
  if args.event:match("Enter$") then
    g.neovide_input_ime = true
  else
    g.neovide_input_ime = false
  end
end
local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  group = ime_input,
  pattern = "*",
  callback = set_ime
})
vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
  group = ime_input,
  pattern = "[/\\?]",
  callback = set_ime
})

return {}
