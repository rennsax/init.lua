return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "LazyFile", "VeryLazy" },
    cmd = {
      "TSInstall",
      "TSBufEnable",
      "TSBufDisable",
      "TSModuleInfo",
    },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc" },

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = { enable = true },

			textobjects = {
				move = {
					enable = true,
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
					goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
				},

        select = {
          enable = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- Superisingly there're no `@argument.{inner,outer}`
            ["ia"] = "@parameter.inner",
            ["aa"] = "@parameter.outer",
          },

          -- selection_modes: default to be `v` (char-wise)
          include_surrounding_whitespace = true,
        },

        swap = {
          enable = true,
          swap_next = {
            ["<leader>a<c-n>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>a<c-p>"] = "@parameter.inner",
          },
        },
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,

		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
	    },
    },
  },

}
