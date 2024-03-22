return {
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
      { '<leader>gst', mode = 'n', builtin.git_status, desc = 'git status' }
    }
  end,

  opts = function()
    local actions = require("telescope.actions")

    local options = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = actions.close },
          -- Personal mappings
          i = {
            ["<Esc>"] = actions.close,
            ["<C-f>"] = false,
            ["<C-h>"] = actions.preview_scrolling_left,
            ["<C-l>"] = actions.preview_scrolling_right,
            -- The two shortcuts conflict with my yabai hotkeys
            -- ["<A-h>"] = actions.results_scrolling_left,
            -- ["<A-l>"] = actions.results_scrolling_right,
          }
        },
      },

      pickers = {
        git_status = {
          git_icons = {
            added = "A",
            changed = "M",
            copied = "C",
            deleted = "D",
            renamed = "R",
            unmerged = "U",
            untracked = "?",
          },
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }
    return options
  end,

  dependencies = { 'nvim-lua/plenary.nvim' }
}
