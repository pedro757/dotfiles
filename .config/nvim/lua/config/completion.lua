local npairs = require('nvim-autopairs')
local lspkind = require('lspkind')
local cmp = require('cmp')

npairs.setup({
  check_ts = true,
  ignored_next_char = string.gsub([[ [%%%'%[%"%.] ]],"%s+", ""),
})

cmp.setup{
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind] ..' '.. vim_item.kind
      return vim_item
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
    -- { name = 'emoji' },
  },
}

M = {}

M.ctrl_l = function()
  if cmp.visible() then
    return cmp.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  else
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<right>', true, true, true), "i", true)
  end
end

M.enter = function()
  if cmp.visible() then
    return cmp.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  else
    return npairs.autopairs_cr()
  end
end
M.scroll_down = function()
  if cmp.visible() then
    return cmp.scroll_docs(-4)
  else
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-d>', true, true, true), "i", true)
  end
end

M.scroll_up = function()
  if cmp.visible() then
    return cmp.scroll_docs(4)
  else
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-u>', true, true, true), "i", true)
  end
end

M.next = function()
  if cmp.visible() then
    cmp.select_next_item(cmp.SelectBehavior.Insert)
  else
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-j>', true, false, true), "i", true)
  end
end

M.prev = function()
  if cmp.visible() then
    cmp.select_prev_item(cmp.SelectBehavior.Insert)
  else
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-k>', true, false, true), "i", true)
  end
end

return M
