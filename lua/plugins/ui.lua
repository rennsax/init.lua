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
      }
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
    dependencies = {
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
    }
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
    config = true,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    init = function()
      -- When which-key is enabled, timeout will pop the key binding window.
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  },
}

return ui_plugins
