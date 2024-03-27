return {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeOpen",
    "NvimTreeFocus",
  },
  keys = {
    {"<D-b>", mode = {'n','i','v'}, "<Cmd>NvimTreeFocus<CR>", desc = 'Focus Nvim-tree' },
    {"<Leader>b", mode = 'n', "<Cmd>NvimTreeFocus<CR>", desc = 'Focus Nvim-tree' },
    { "<leader>e", mode = 'n', "<Cmd>NvimTreeToggle<CR>", desc = 'Toggle Nvim-tree' },
    { "<leader>E", mode = 'n', "<Cmd>NvimTreeFindFile<CR>", desc = 'Find current file in Nvim-tree' }
  },

  opts = {
    filters = {
      dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    view = {
      adaptive_size = false,
      side = "left",
      width = 30,
      preserve_window_proportions = true,
    },
    git = {
      enable = true,
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      root_folder_label = false,
      highlight_git = true,
      highlight_opened_files = "none",

      indent_markers = {
        enable = true,
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },

        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  },
}
