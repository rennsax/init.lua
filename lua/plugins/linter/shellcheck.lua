return  {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "shellcheck")
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft, {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      })
      opts.linters = vim.tbl_extend("force", opts.linters, {
        shellcheck = {
          cmd = "shellcheck",
          condition = function(ctx)
            local is_cheatsheet = #vim.fs.find("cheatsheets", {
              upward = true,
              path = ctx.dirname,
              type = "directory",
            }) > 0

            if is_cheatsheet then
              return false
            end
            return true
          end,
        }
      })
    end
  },

}
