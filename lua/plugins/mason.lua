return {
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
