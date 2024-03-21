if vim.g.vscode then
  return {}
end

-- Options must be wrapped in a callback since it requires some modules.
local get_nvim_cmp_options = function()
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  local options = {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },

    -- The order of the sources determines their order in the completion results.
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- L3MON4D3/LuaSnip
      { name = "nvim_lua" }, -- hrsh7th/cmp-nvim-lua
    }, {
      { name = "buffer" }, -- hrsh7th/cmp-buffer
      { name = "path" }, -- hrsh7th/cmp-path
    }),

    mapping = {
      ['<C-Space>'] = function(fallback)
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end,
      ['<Tab>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<CR>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, {'i','s'}),
      ["<M-CR>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {'i','s'}),
    },
  }
  return options
end

-- dep chain: nvim-cmp -> { LuaSnip, cmp_luasnip, ... } -> friendly-snippets
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- snippet engine
      {
        "L3MON4D3/LuaSnip",
        opts = {
          history = true,
          delete_check_events = "TextChanged",
        },
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          }
        },
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources
      {
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua", -- Neovim Lua API
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      }
    },
    opts = get_nvim_cmp_options,
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      require("cmp").setup(opts)
    end
  }
}

