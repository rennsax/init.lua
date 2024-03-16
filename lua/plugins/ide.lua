return {
  {
    "hrsh7th/nvim-cmp",
    enabled = not vim.g.vscode,
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
      {"<Leader>u", mode = "n", function() vim.cmd.UndotreeToggle() end, { desc = "Toggle Undotree" }}
    },
    config = function()
      vim.g.undotree_WindowLayout = 3
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    enabled = not vim.g.vscode,
    opts = {
      -- ensure_installed = { "lua", "vim", "vimdoc" },

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = { enable = true },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    enabled = not vim.g.vscode,
    event = "VeryLazy",
    cmd = nil,
    opts = function()
      local conf = require "nvchad.configs.telescope"

      conf.defaults.mappings.i = {
        ["<Esc>"] = require("telescope.actions").close,
        ["jj"] = require("telescope.actions").close,
      }

      return conf
    end,

    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- Personal keymaps 8<
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set({'n','v','i'}, '<D-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leade>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set({'n','v','i'}, '<D-o>', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      -- End personal keymaps >8

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sc', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [C]onfiguration files' })

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    enabled = not vim.g.vscode,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    'wakatime/vim-wakatime',
    enabled = not vim.g.vscode,
    event = "VeryLazy"
  }
}
