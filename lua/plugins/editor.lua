return {
  {
    "haya14busa/vim-asterisk",
    keys = {
      {'*', mode = '', '<Plug>(asterisk-*)'},
      {'#', mode = '', '<Plug>(asterisk-#)'},
      {'g*', mode = '', '<Plug>(asterisk-g*)'},
      {'g#', mode = '', '<Plug>(asterisk-g#)'},
      {'z*', mode = '', '<Plug>(asterisk-z*)'},
      {'gz*', mode = '', '<Plug>(asterisk-gz*)'},
      {'z#', mode = '', '<Plug>(asterisk-z#)'},
      {'gz#', mode = '', '<Plug>(asterisk-gz#)'},
    },
  },

  {
    "folke/flash.nvim",
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
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = "BufEnter",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup {
        custom_textobjects = {
          n_lines = 500,
          -- mini.ai applies its own bracket aliases
          -- which alias b to "),] and }"
          b = false,
          -- Whole buffer
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1)
            }
            return { from = from, to = to }
          end
        }
      }

      -- require("mini.comment").setup()

      -- require("mini.trailspace").setup()

      if not vim.g.vscode then
        require("mini.cursorword").setup({
          delay = 400
        })
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  {
    "vim-scripts/ReplaceWithRegister",
    event = "BufEnter",
  },

  {
    -- TODO try mini.surround
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufEnter",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }
}
