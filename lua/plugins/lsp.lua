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

    dependencies = {
      "nvim-cmp",
      "nvim-lspconfig",
    },
  },

  {
    'neovim/nvim-lspconfig',
    cmd = "LspInfo",
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      "cmp-nvim-lsp"
    },

    config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({
          buffer = bufnr,
          perserve_mappings = false,
        })
      end)

      -- (Optional) Configure lua language server for neovim
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end
  }

}
