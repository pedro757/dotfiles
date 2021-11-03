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
    format = lspkind.cmp_format(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'rg' }
  },
}

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

M = {}

M.ctrl_l = function()
  local mode = vim.api.nvim_get_mode()
  if cmp.visible() then
    return cmp.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
      function()
	if mode.mode == "c" then
	  return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true), "i", true)
	end
      end)
  else
    if mode.mode == "c" then
      return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true), "i", true)
    end
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
    return nil
  end
end

M.scroll_up = function()
  if cmp.visible() then
    return cmp.scroll_docs(4)
  else
    return nil
  end
end

M.next = function()
  if cmp.visible() then
    cmp.select_next_item(cmp.SelectBehavior.Insert)
  else
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<down>', true, false, true), "i", true)
  end
end

M.prev = function()
  if cmp.visible() then
    cmp.select_prev_item(cmp.SelectBehavior.Insert)
  else
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<up>', true, false, true), "i", true)
  end
end

return M
