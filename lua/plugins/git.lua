-- git integration plugins

if vim.g.vscode then
  return {}
end

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = " " },
        topdelete    = { text = "▔" },
        changedelete = { text = "~" },
        untracked    = { text = "┇" },
      },
      -- Also show gitsigns in untracked files.
      attach_to_untracked = true,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "[G]it [H]unk [S]tage")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "[G]it [H]unk [R]eset")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "[G]it [H]unk [U]ndo")
        map("n", "<leader>ghS", gs.stage_buffer, "[G]it Buffer [S]tage")
        map("n", "<leader>ghR", gs.reset_buffer, "[G]it Buffer [R]eset")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "[G]it [H]unk [P]review")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "[G]it Line [B]lame")
        -- map("n", "<leader>gd", gs.diffthis, "[G]it [D]iff")
        -- map("n", "<leader>gD", function() gs.diffthis("~") end, "[G]it [D]iff HEAD~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "git hunk")
      end
    },
  },
  -- Fugitive - git integration. Useful and dedicate!
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      -- Tip: use <c-w>o to quit the diff mode.
      { '<leader>gd', '<cmd>Gvdiffsplit<cr>', desc = '[G]it [D]iff' },
      { '<leader>gD', '<cmd>Gvdiffsplit HEAD~<cr>', desc = "[G]it [D]iff HEAD~" },
      { '<leader>gg', '<cmd>Gvsplit :<cr>', desc = "fugitive summary vertical" },
      { '<leader>gG', '<cmd>Git<cr>', desc = "fugitive summary" },
    },
  }
}
