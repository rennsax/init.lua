if vim.g.vscode then
  return {}
end

require("lazyvim.util").lazy_file()

local ui_plugins = {

  {
    -- required by many plugins
    "nvim-tree/nvim-web-devicons",
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = function ()
      return require("plugins.configs.gitsigns")
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFocus",
    },
    keys = {
      {"<D-b>", mode = {'n','i','v'}, "<Cmd>NvimTreeFocus<CR>", { desc = 'Toggle Nvim-tree' }},
      {"<Leader>b", mode = '', "<Cmd>NvimTreeFocus<CR>", { desc = 'Toggle Nvim-tree' }},
    },

    opts = function()
      return require("plugins.configs.nvim-tree")
    end
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    opts = {
      -- Remove the background of LineNr, {Sign,Fold}Column and friends
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      },
      dimInactive = true,
      overrides = function(colors)
        return {
          WinSeparator = {
            -- Make the window separator more visible
            bg = colors.palette.bg_m3,
            fg = colors.palette.oniViolet,
          },
        }
      end
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd "colorscheme kanagawa"
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        middle_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        right_mouse_command = nil,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorer",
            highlight = "Directory",
            text_aligh = "left",
          }
        }
      }
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>x",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "[T]ab [D]elete (replace :bd)",
      },
      -- stylua: ignore
      { "<leader>X", function() require("mini.bufremove").delete(0, true) end, desc = "Forcely [T]ab [D]elete (replace :bD)" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          globalstatus = true
        }
      }
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      triggers_nowait = {
        -- marks
        "`",
        "'",
        "g`",
        "g'",
        -- registers
        '"',
        "<c-r>",
        -- spelling
        "z=",
      },
    },
  },

  {
    'norcalli/nvim-colorizer.lua',
    cmd = "ColorizerToggle",
    config = true
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "LazyFile",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      -- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      -- { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      -- { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      -- { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

}

return ui_plugins
