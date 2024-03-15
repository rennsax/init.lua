return { -- Collection of various small independent plugins/modules
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

    require("mini.comment").setup()

    -- require("mini.trailspace").setup()

    require("mini.cursorword").setup({
        delay = 400
    })

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
