-- NvChad related mapping
local map = vim.keymap.set

-- tabufline

-- close buffer w/o closing the window (:bd)
map({'i','n','v'}, "<D-w>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer Close" })

map("n", "<Leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer Close" })

map({'i','n','v'}, "<D-t>", "<cmd>enew<CR>", { desc = "Buffer New" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })
map({'i','n','v'}, "<D-}>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })
map({'i','n','v'}, "<D-{>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer Goto prev" })

-- terminal

-- new terminals
map("n", "<leader>tnh", function()
  require("nvchad.term").new { pos = "sp", size = 0.3 }
end, { desc = "[T]erminal [N]ew [H]orizontal term" })

map("n", "<leader>tnv", function()
  require("nvchad.term").new { pos = "vsp", size = 0.3 }
end, { desc = "[T]erminal [N]ew [V]ertical window" })

-- toggleable
map("n",  "<Leader>ttv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.3 }
end, { desc = "[T]erminal [T]oggleable [V]ertical term" })

map("n",  "<Leader>tth", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.3 }
end, { desc = "[T]erminal [T]oggleable [H]orizontal term" })
map({ "n", "t", "i" }, "<D-j>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.3 }
end, { desc = "[T]erminal [T]oggleable [H]orizontal term" })

map("n",  "<Leader>ttf", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "[T]erminal [T]oggle [F]loating term" })
map({ "n", "t" }, "<D-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal Toggle Floating term" })

map("t", "<ESC>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true)
end, { desc = "Terminal Close term in terminal mode" })
