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
    event = "LazyFile",
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
      lua_opts.autostart = false
      require('lspconfig').lua_ls.setup(lua_opts)
    end
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      -- PATH = "skip",
      pip = {
        install_args = { "--index-url", "https://pypi.tuna.tsinghua.edu.cn/simple" }
      },
      ui = {
        check_outdated_packages_on_open = false,
        icons = {
            package_installed = "✓ ",
            package_pending = "➜ ",
            package_uninstalled = " ✗"
        },
        width = 0.6,
        height = 0.8,
      },
      max_concurrent_installers = 8,
      ensure_installed = {
        "shfmt",
      },
    },
    config = function (_, opts)
      require("mason").setup(opts)

      -- Extend the "ensure_installed" field.
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed or {}) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      -- Automatically install ensured packages.
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end
  },

}
