if vim.g.vscode then
  return {}
end

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
