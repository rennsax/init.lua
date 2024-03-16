local cmp = require "cmp"
local options = require "nvchad.configs.cmp"
local luasnip = require "luasnip"

options.mapping = {
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
}

return options
