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
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    keys = function ()
      local builtin = require('telescope.builtin')
      return {
        { '<leader>sh', mode = 'n', builtin.help_tags,  desc = '[S]earch [H]elp' },
        { '<leader>sk', mode = 'n', builtin.keymaps, desc = '[S]earch [K]eymaps' },
        { '<leader>sf', mode = 'n', builtin.find_files, desc = '[S]earch [F]iles' },
        { '<D-p>', mode = {'n','v','i'}, builtin.find_files, desc = '[S]earch [F]iles' },
        { '<leade>ss', mode = 'n', builtin.builtin, desc = '[S]earch [S]elect Telescope' },
        { '<leader>sw', mode = 'n', builtin.grep_string, desc = '[S]earch current [W]ord' },
        { '<leader>rg', mode = 'n', builtin.live_grep, desc = '[R]ip[G]rep' },
        { '<leader>sd', mode = 'n', builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
        { '<leader>sr', mode = 'n', builtin.resume, desc = '[S]earch [R]esume' },
        { '<leader>s.', mode = 'n', builtin.oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },
        { '<D-o>', mode = {'n','v','i'}, builtin.oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },
        { '<leader><leader>', mode = 'n', builtin.buffers, desc = '[ ] Find existing buffers' },
        {
          '<Leader>/', mode = 'n', function ()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
              winblend = 10,
              previewer = false,
            })
          end, desc = '[/] Fuzzily search in current buffer' 
        },
        {
          '<Leader>sc', mode = 'n', function ()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
          end, desc = '[S]earch [C]onfiguration files' 
        },
        { '<leader>st', mode = 'n', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odos'  },
      }
    end,

    opts = function()
      return require("plugins.configs.telescope")
    end,

    dependencies = { 'nvim-lua/plenary.nvim' }
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
