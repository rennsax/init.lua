if vim.g.vscode then
  return {}
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- snippet engine
      {
        "L3MON4D3/LuaSnip",
        opts = {
          history = true,
          delete_check_events = "TextChanged",
        },
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources
      {
        -- "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      }
    },
    opts = function()
      return require "plugins.configs.cmp"
    end
  },

  {
    'Exafunction/codeium.vim',
    enabled = false,
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set('i', '<C-i>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })

      vim.g.codeium_enabled = false
    end
  },

  {
    "mbbill/undotree",
    keys = {
      {"<Leader>u", mode = "n", function() vim.cmd.UndotreeToggle() end, desc = "Toggle Undotree" }
    },
    init = function()
      vim.g.undotree_WindowLayout = 3
    end
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    'wakatime/vim-wakatime',
    event = "VeryLazy"
  },

  -- Fugitive - git integration. Useful and dedicate!
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  }
}
