local npairs = require "nvim-autopairs"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp = require "cmp"

npairs.setup {
  check_ts = true,
}

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done { map_char = { tex = "" } }
)
