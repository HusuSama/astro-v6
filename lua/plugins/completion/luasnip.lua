return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
    require("luasnip.loaders.from_lua").lazy_load {
      paths = { vim.fn.stdpath "config" .. "/lua/snippets" },
    }
    require("luasnip").filetype_extend("javascript", { "javascriptreact" })
  end,
  keys = {
    {
      "<C-Enter>",
      mode = { "i" },
      "<Plug>luasnip-expand-or-jump",
      desc = "luasnip expand or jump",
    },
  },
}
