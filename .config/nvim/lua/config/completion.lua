local npairs = require('nvim-autopairs')
local lspkind = require('lspkind')
local cmp = require('cmp')

npairs.setup({
  check_ts = true,
  ignored_next_char = string.gsub([[ [%%%'%[%"%.] ]],"%s+", ""),
  -- fast_wrap = {},
})


cmp.setup{
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind] ..' '.. vim_item.kind
      return vim_item
    end
  },
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lua' },
    { name = 'path' },
  },
}

M = {}

M.ctrl_l = function()
  if vim.fn.pumvisible() == 1 then
    return cmp.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  else
    return vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<right>', true, true, true))
  end
end
M.enter = function()
  if vim.fn.pumvisible() == 1 then
    return cmp.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  else
    return npairs.autopairs_cr()
  end
end
M.scroll_down = function()
  if vim.fn.pumvisible() == 1 then
    return cmp.scroll_docs(-4)
  else
    return vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<c-d>', true, true, true))
  end
end

M.scroll_up = function()
  if vim.fn.pumvisible() == 1 then
    return cmp.scroll_docs(4)
  else
    return vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<c-u>', true, true, true))
  end
end

return M
