return {
  "folke/flash.nvim",
  event = "BufEnter",
  opts = {
    modes = {
      -- Try to use <c-s> when it's necessary to toggle flash.
      search = { enabled = false },
      -- Discard this feature, or flash.nvim can be too complex to master.
      char = { enabled = false },
      jump = {
        inclusive = false
      }
    },
    label = {
      -- show the label before the match
      before = true,
      after = false,
    },
  },
  ---@type Flash.Config
  -- See `:help map-table` for the meaning of each abbreviation option.
  -- stylua: ignore
  keys = {
    { "f", mode = { "n", "x", "o" }, function() require("flash").jump({
      jump = { inclusive = false }
    }) end, desc = "Simple [F]lash" },

    -- Start selecting surrounding treesitter nodes from the current cursor.
    { "<leader>ft", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "[F]lash [T]reesitter" },

    -- Remote flash is really useful in operator pending mode.
    -- It marks the current cursor position, jump to remote place to perform any motion,
    -- and then jump back to the original position.
    -- Remote motions are even done across windows.
    { "r", mode = "o", function() require("flash").remote() end, desc = "[R]emote Flash" },

    -- Open **flash** in **Treesitter Search** mode
    -- Arround the matches, all the surrounding treesitter nodes will be labeled.
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },

    -- Toggle flash, command-line-mode only. For example, toggle flash when searching pattern with `/` and `?`
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
