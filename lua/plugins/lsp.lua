if vim.g.vscode then
  return {}
end

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  {
    'neovim/nvim-lspconfig',
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = "LazyFile",
    dependencies = {
      "cmp-nvim-lsp",
      { "williamboman/mason-lspconfig.nvim" },
    },

    config = function(_, opts)

      -- Overwrite the global defaults.
      local lspconfig = require("lspconfig")
      lspconfig.util.default_config = vim.tbl_extend(
        "force",
        lspconfig.util.default_config,
        {
          -- Explicitly enable LSP with ":LspStart"
          autostart = false,
        }
      )

      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        local buf_local_opts = function(opts)
          opts.buffer = bufnr
          return opts
        end

        vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, buf_local_opts { desc = "lsp hover" })
        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, buf_local_opts { desc = "signature help" })
        vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, buf_local_opts { desc = "signature help" })

        vim.keymap.set("n", "gd", function()
          require("telescope.builtin").lsp_definitions({reuse_win = true})
        end, buf_local_opts { desc = "definitions" })

        vim.keymap.set("n", "gR", function()
          require("telescope.builtin").lsp_references({reuse_win = true})
        end, buf_local_opts { desc = "references" })

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_local_opts { desc = "implementations" })

        vim.keymap.set("n", "gI", function()
          require("telescope.builtin").lsp_implementations({reuse_win = true})
        end, buf_local_opts { desc = "implementations" })

        vim.keymap.set("n", "gy", function()
          require("telescope.builtin").lsp_type_definitions({reuse_win = true})
        end, buf_local_opts { desc = "t[y]pe definitions" })

        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, buf_local_opts { desc = "rename symbol" })
      end)

      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,

          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(vim.tbl_extend("force", lua_opts, { autostart = true }))
          end,

          jdtls = function()
            require('lspconfig').jdtls.setup({})
          end,
        },
      })

    end
  },

}
