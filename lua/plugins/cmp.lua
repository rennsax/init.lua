if vim.g.vscode then
  return {}
end

local get_nvim_cmp_options = function()
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  local options = {
    sources = cmp.config.sources({
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
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
        if require("luasnip").jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, {'i','s'}),
      ["<M-CR>"] = cmp.mapping(function(fallback)
        if require("luasnip").jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {'i','s'}),
    },
  }
  return options
end

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
        -- "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      }
    },
    opts = get_nvim_cmp_options,
  }
}
