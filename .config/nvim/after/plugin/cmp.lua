if
  not pcall(require, "cmp")
  or not pcall(require, "lspkind")
  or not pcall(require, "luasnip")
  or not pcall(require, "nvim-autopairs")
then
  return
end

local luasnip = require "luasnip"

-- require("luasnip/loaders/from_vscode").lazy_load()
luasnip.config.setup {
  update_events = "TextChanged,TextChangedI",
  region_check_events = "InsertEnter",
}

require("luasnip.loaders.from_lua").lazy_load {
  paths = "~/Documents/snippets/",
}

local utils = require "utils"
local t = utils.t
local lspkind = require "lspkind"
local cmp = require "cmp"

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
    { name = "luasnip" },
  }, {
    { name = "emmet_vim" },
    { name = "buffer" },
    { name = "path" },
  }, {
    { name = "rg" },
  }),
  mapping = {
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-x>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(
      cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      { "i", "c" }
    ),
    ["<C-k>"] = cmp.mapping(
      cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      { "i", "c" }
    ),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      else luasnip.locally_jumpable(-1)
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
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
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}

cmp.setup.filetype("lua", {
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "path" },
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
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})

local npairs = require "nvim-autopairs"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"

npairs.setup {
  check_ts = true,
  break_undo = false,
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local Rule   = require'nvim-autopairs.rule'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end
