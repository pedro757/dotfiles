if
  -- not pcall(require, "cmp")
  -- or not pcall(require, "lspkind")
  -- or not pcall(require, "luasnip")
  -- or not pcall(require, "nvim-autopairs")
  -- or not pcall(require, "copilot")
  true
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
    ["<C-x>"] = cmp.mapping {
      c = cmp.mapping.close(),
      i = function(fallback)
        if cmp.visible() then
          cmp.close()
        elseif require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").dismiss()
        else
          fallback()
        end
      end,
    },
    ["<C-j>"] = cmp.mapping {
      c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
        elseif require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          fallback()
        end
      end,
    },
    ["<C-k>"] = cmp.mapping(
      cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      { "i", "c" }
    ),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
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
      i = function(fallback)
        if cmp.visible() then
          cmp.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }
        elseif require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept_line()
        else
          fallback()
        end
      end,
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
    completion = cmp.config.window.bordered {
      winhighlight = "FloatBorder:FloatBorder",
    },
    documentation = cmp.config.window.bordered {
      winhighlight = "FloatBorder:FloatBorder",
    },
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

require("cmp-tw2css").setup()

cmp.setup.filetype({ "css", "scss", "less", "sass" }, {
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "cmp-tw2css" },
    { name = "emmet_vim" },
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
--
-- cmp.event:on("menu_opened", function()
--   vim.b.copilot_suggestion_hidden = true
-- end)
--
-- cmp.event:on("menu_closed", function()
--   vim.b.copilot_suggestion_hidden = false
-- end)
--
local npairs = require "nvim-autopairs"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"

npairs.setup {
  check_ts = true,
  break_undo = false,
  enable_abbr = true,
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local Rule = require "nvim-autopairs.rule"
local cond = require "nvim-autopairs.conds"

npairs.add_rules {
  Rule(" ", " ")
    :with_pair(cond.done())
    :replace_endpair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      if vim.tbl_contains({ "()", "{}", "[]" }, pair) then
        return " " -- it return space here
      end
      return "" -- return empty
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
    end),
}
