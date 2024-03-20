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
      {"<D-b>", mode = {'n','i','v'}, "<Cmd>NvimTreeFocus<CR>", desc = 'Focus Nvim-tree' },
      {"<Leader>b", mode = 'n', "<Cmd>NvimTreeFocus<CR>", desc = 'Focus Nvim-tree' },
      {
        "<leader>e", mode = 'n', "<Cmd>NvimTreeToggle<CR>", desc = 'Toggle Nvim-tree'
      }
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
        local theme = colors.theme
        local palette = colors.palette
        return {
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          TelescopePreviewTitle = { bg = palette.waveAqua1 },
          TelescopePromptTitle = { bg = palette.waveRed },
          TelescopeResultsTitle = { bg = theme.ui.bg_m1, fg = theme.ui.bg_m1 },
          WinSeparator = {
            -- Make the window separator more visible
            bg = palette.bg_m3,
            fg = palette.oniViolet,
          },
          Visual = {
            bg = palette.waveBlue2,
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
        },
        --- count is an integer representing total count of errors
        --- level is a string "error" | "warning"
        --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
        --- this should return a string
        --- Don't get too fancy as this function will be executed a lot
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
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

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      -- { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      -- { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      -- { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>.", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- Lua
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      "<leader>zz", "<cmd>ZenMode<cr>", mode = "n",
      desc = "Toggle [Z]en Mode"
    },
    opts = {
      plugins = {
        tmux = { enabled = true }
      },
    }
  },
}

return ui_plugins
