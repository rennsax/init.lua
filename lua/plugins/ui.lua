require("lazyvim.util").lazy_file()

local ui_plugins = {

  {
    -- required by many plugins
    "nvim-tree/nvim-web-devicons",
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
          TelescopeResultsDiffAdd = { bg = theme.ui.bg_m1 },
          TelescopeResultsDiffChange = { bg = theme.ui.bg_m1 },
          TelescopeResultsDiffDelete = { bg = theme.ui.bg_m1 },
          TelescopeResultsDiffUntracked = { bg = theme.ui.bg_m1 },
          WinSeparator = {
            -- Make the window separator more visible
            bg = palette.bg_m3,
            fg = palette.oniViolet,
          },
          Visual = {
            bg = palette.waveBlue2,
          },
          RainbowDelimiterRed = { fg = palette.waveRed },
          RainbowDelimiterYellow = { fg = palette.carpYellow },
          RainbowDelimiterBlue = { fg = palette.waveBule2 },
          RainbowDelimiterOrange = { fg = palette.dragonOrange2 },
          RainbowDelimiterGreen = { fg = palette.dragonGreen },
          RainbowDelimiterViolet = { fg = palette.oniViolet2 },
          RainbowDelimiterCyan = { fg = palette.waveAqua2 },
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
    opts = function()
      return {
        indent = {
          char = "▏",
          tab_char = "▏",
        },
        scope = {
          -- TODO: scope color?
          enabled = true,
        },
        exclude = {
          filetypes = require("lazyvim.config").native_fts,
        },
      }
    end,
    main = "ibl",
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader><S-tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<D-{>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<leader><tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<D-}>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
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
      { '<leader>st', mode = 'n', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odos' },
      -- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      -- { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
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
      {
        "<leader>zz", mode = "n", "<cmd>ZenMode<cr>",
        desc = "Toggle [Z]en Mode",
      }
    },
    opts = {
      window = {
        width = 105,
      },
      plugins = {
        tmux = { enabled = false }
      },
    }
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",
    opts = {
      symbol = "▏",
      -- symbol = "│",
      options = { try_as_border = true },
      symbol = '❙',
    },
    init = function()
      local pattern = require("lazyvim.config").native_fts
      vim.api.nvim_create_autocmd("FileType", {
        pattern = pattern,
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  {
    -- Show the colorcolumn as a char with highlight group "NonText"
    'lukas-reineke/virt-column.nvim',
    event = "VeryLazy",
    opts = {
      char = "▏",
    },
  },


  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },

  {
    'numToStr/FTerm.nvim',
    opts = {},
    keys = {
      { "<leader>f", mode = "n", function() require("FTerm").toggle() end, desc = "Toggle Float Term" },
    },
  },

  {
    -- Replace vim.ui.input and vim.ui.select.
    "stevearc/dressing.nvim",
    -- A trick to lazy load dressing.nvim.
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Highly experimental plugin that completely replaces the UI for
  -- messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        format = {
          search_down = { icon = " " },
          search_up = { icon = " " },
          filter = false,
        },
      },
      messages = {
        -- TODO: whether to keep using nvim-notify to show every message?
        -- enabled = false,
      },
      lsp = {
        -- TODO: I have to disable these two now (maybe because of lsp-zero)
        signature = { enabled = false },
        hover = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },

    },
    dependencies = {
      { "MunifTanjim/nui.nvim" },

      {
        "rcarriga/nvim-notify",
        keys = {
          {
            "<leader>c",
            function()
              require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Dismiss all notify",
          },
        },
        opts = {
          timeout = 3000,
          max_height = function()
            return math.floor(vim.o.lines * 0.75)
          end,
          max_width = function()
            -- Smaller width, or the notify window will conver the text on my laptop.
            return math.floor(vim.o.columns * 0.2)
          end,
          on_open = function(win)
            vim.api.nvim_win_set_config(win, { zindex = 100 })
          end,
        },
        init = function()
          local util = require("lazyvim.util")
          -- when noice is not enabled, install notify on verylazy
          if not util.has("noice.nvim") then
            util.on_very_lazy(function()
              vim.notify = require("notify")
            end)
          end
        end,
      }
    }
  },

}

return ui_plugins
