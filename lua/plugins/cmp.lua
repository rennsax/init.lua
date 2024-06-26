-- Options must be wrapped in a callback since it requires some modules.
local cmp_options = function()
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  local defaults = require("cmp.config.default")()

  local options = {

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    completion = {
      completeopt = "menu,menuone,noinsert",
    },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
      -- completion = {
      --   scrollbar = false,
      -- },
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
      ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
          else
            fallback()
          end
        end,
        { 'i' } -- only in insert mode
      ),
      -- TODO: I have to add this, or <C-e> would close the completion window
      -- first. Don't know why.
      ["<C-e>"] = cmp.mapping(function(fallback)
        fallback()
      end, {'i'}),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-c>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.abort()
        else
          fallback()
        end
      end),
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

    formatting = {
      format = function(_, item)
        local icons = require("lazyvim.config").icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    },
    -- performance = {
    --   max_view_entries = 20,
    -- },
    sorting = defaults.sorting,
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
        config = function (_, opts)
          require("luasnip").setup(opts)

          -- Remove snippet from the jumplist when we are "back to normal"
          -- This is a workaround found at:
          -- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
          vim.api.nvim_create_autocmd('ModeChanged', {
            pattern = '*',
            callback = function()
              if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') -- s -> v
                or vim.v.event.old_mode == 'i' ) -- i -> any
                and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require('luasnip').session.jump_active
              then
                require('luasnip').unlink_current()
              end
            end
          })
        end
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
    opts = cmp_options,
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      require("cmp").setup(opts)
    end
  }
}

