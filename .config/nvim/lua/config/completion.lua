local npairs = require('nvim-autopairs')

npairs.setup({
  check_ts = true,
  ignored_next_char = string.gsub([[ [%%%'%[%"%.] ]],"%s+", ""),
  -- fast_wrap = {},
})

_G.MUtils= {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm=function(tipo)
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      vim.defer_fn(function()
        vim.fn["compe#confirm"]("<cr>")
      end, 1)
      return npairs.esc("<c-n>")
    end
  else
    if tipo ~= 0 then
      -- Pressing Enter
      return npairs.autopairs_cr()
    else
      -- Pressing <C-l>
      return npairs.esc("<right>")
    end
  end
end

-- map('i' , '<CR>','v:lua.MUtils.completion_confirm(1)', {expr = true , noremap = true})
-- map('i' , '<c-l>','v:lua.MUtils.completion_confirm(0)', {expr = true , noremap = true})

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    luasnip = true;
    emoji = true;
  };
}
