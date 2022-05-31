-- require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip").config.setup {
  update_events = "TextChanged,TextChangedI",
}

require("luasnip.loaders.from_lua").lazy_load {
  paths = "~/Documents/snippets/",
}
