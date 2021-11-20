local function prequire(...)
  local status, lib = pcall(require, ...)
  if (status) then return lib end
  return nil
end

local npairs = prequire'nvim-autopairs'
local luasnip = prequire'luasnip'
local cmp_autopairs = prequire'nvim-autopairs.completion.cmp'
local lspkind = prequire'lspkind'
local cmp = prequire'cmp'

npairs.setup({
  check_ts = true,
  ignored_next_char = string.gsub([[ [%%%'%[%"%.] ]],"%s+", ""),
})

cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

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
cmp.setup.cmdline('?', {
  sources = {
    { name = 'buffer' }
  }
})
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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M = {}

M.tab_complete = function()
  if cmp and cmp.visible() then
    return cmp.select_next_item()
  elseif luasnip and luasnip.expand_or_jumpable() then
    return luasnip.expand_or_jump()
  end
  return vim.api.nvim_feedkeys(t"<c-t>", "", true)
end
M.s_tab_complete = function()
  if cmp and cmp.visible() then
    return cmp.select_prev_item()
  elseif luasnip and luasnip.jumpable(-1) then
    return luasnip.jump(-1)
  end
  return vim.api.nvim_feedkeys(t"<c-d>", "", true)
end

M.ctrl_l = function()
  local mode = vim.api.nvim_get_mode()
  if cmp.visible() then
    return cmp.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
      function()
        if mode.mode == "c" then
          return vim.api.nvim_feedkeys(t'<CR>', "i", true)
	end
      end)
  else
    if mode.mode == "c" then
      return vim.api.nvim_feedkeys(t'<CR>', "i", true)
    end
    return vim.api.nvim_feedkeys(t'<right>', "i", true)
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
    return t'<C-d>'
  end
end

M.scroll_up = function()
  if cmp.visible() then
    return cmp.scroll_docs(4)
  else
    return t'<C-u>'
  end
end

M.next = function()
  if cmp.visible() then
    cmp.select_next_item(cmp.SelectBehavior.Insert)
  else
    return vim.api.nvim_feedkeys(t'<down>', "", true)
  end
end

M.prev = function()
  if cmp.visible() then
    cmp.select_prev_item(cmp.SelectBehavior.Insert)
  else
    return vim.api.nvim_feedkeys(t'<up>', "", true)
  end
end

return M
