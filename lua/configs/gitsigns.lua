local opts = require "nvchad.configs.gitsigns"

-- Overwrite the default options
-- Disable default key mappings
opts.on_attach = nil
return opts
