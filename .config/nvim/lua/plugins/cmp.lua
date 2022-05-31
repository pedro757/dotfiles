local utils = require "utils"
local t = utils.t
local luasnip = require "luasnip"
local lspkind = require "lspkind"
local cmp = require "cmp"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match "%s"
      == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format(),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  }, {
    { name = "rg" },
  }),
  mapping = {
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-x>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(
      cmp.mapping.select_next_item(cmp.SelectBehavior.Insert),
      { "i", "c" }
    ),
    ["<C-k>"] = cmp.mapping(
      cmp.mapping.select_prev_item(cmp.SelectBehavior.Insert),
      { "i", "c" }
    ),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-l>"] = cmp.mapping {
      i = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }, function()
            return vim.api.nvim_feedkeys(t "<CR>", "c", true)
          end)
        else
          fallback()
        end
      end,
    },
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
}

cmp.setup.filetype("lua", {
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
  }, {
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  }, {
    { name = "rg" },
  }),
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" },
  }, {
    { name = "nvim_lsp" },
    { name = "buffer" },
  }),
})

cmp.setup.cmdline("?", {
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
