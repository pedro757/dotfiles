if not pcall(require, "lspconfig") then
  return
end
if not pcall(require, "null-ls") then
  return
end

local nvim_lsp = require "lspconfig"
local null_ls = require "null-ls"

local on_attach = function(client, bufnr)
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", {})
  if client.server_capabilities.colorProvider then
    require("document-color").buf_attach(bufnr, { mode = "background" })
  end
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec2(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        autocmd CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      { output = false }
    )
  end
  --
  -- vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
  --
  -- vim.api.nvim_create_autocmd("InsertEnter", {
  --   buffer = bufnr,
  --   callback = function()
  --     vim.lsp.buf.inlay_hint(bufnr, true)
  --   end,
  --   group = "lsp_augroup",
  -- })
  -- vim.api.nvim_create_autocmd("InsertLeave", {
  --   buffer = bufnr,
  --   callback = function()
  --     vim.lsp.buf.inlay_hint(bufnr, false)
  --   end,
  --   group = "lsp_augroup",
  -- })
end

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- require("typescript-tools").setup {
--   on_attach = on_attach,
--   settings = {
--     -- spawn additional tsserver instance to calculate diagnostics on it
--     separate_diagnostic_server = true,
--     -- "change"|"insert_leave" determine when the client asks the server about diagnostic
--     publish_diagnostic_on = "insert_leave",
--     -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
--     -- "remove_unused_imports"|"organize_imports") -- or string "all"
--     -- to include all supported code actions
--     -- specify commands exposed as code_actions
--     expose_as_code_action = {},
--     -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
--     -- not exists then standard path resolution strategy is applied
--     tsserver_path = nil,
--     -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
--     -- (see 💅 `styled-components` support section)
--     tsserver_plugins = {},
--     -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
--     -- memory limit in megabytes or "auto"(basically no limit)
--     tsserver_max_memory = "auto",
--     -- described below
--     tsserver_format_options = {},
--     -- locale of all tsserver messages, supported locales you can find here:
--     -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
--     tsserver_locale = "en",
--     -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
--     complete_function_calls = false,
--     include_completions_with_insert_text = true,
--     -- CodeLens
--     -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
--     -- possible values: ("off"|"all"|"implementations_only"|"references_only")
--     code_lens = "off",
--     -- by default code lenses are displayed on all referencable values and for some of you it can
--     -- be too much this option reduce count of them by removing member references from lenses
--     disable_member_code_lens = true,
--     -- JSXCloseTag
--     -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
--     -- that maybe have a conflict if enable this feature. )
--     jsx_close_tag = {
--         enable = false,
--         filetypes = { "javascriptreact", "typescriptreact" },
--     },
--     tsserver_file_preferences = {
--       includeInlayParameterNameHints = "all",
--       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--       includeInlayFunctionParameterTypeHints = true,
--       includeInlayVariableTypeHints = true,
--       includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--       includeInlayPropertyDeclarationTypeHints = true,
--       includeInlayFunctionLikeReturnTypeHints = true,
--       includeInlayEnumMemberValueHints = true,
--     },
--   },
-- }

nvim_lsp.emmet_language_server.setup{}

-- require("typescript").setup {
--   server = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     root_dir = function(fname)
--       return require("lspconfig.util").root_pattern ".git"(fname)
--         or require("lspconfig.util").root_pattern "tsconfig.json"(fname)
--         or require("lspconfig.util").root_pattern(
--           "package.json",
--           "jsconfig.json"
--         )(fname)
--     end,
--     settings = {
--       typescript = {
--         inlayHints = {
--           includeInlayParameterNameHints = "all",
--           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--           includeInlayFunctionParameterTypeHints = true,
--           includeInlayVariableTypeHints = true,
--           includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--           includeInlayPropertyDeclarationTypeHints = true,
--           includeInlayFunctionLikeReturnTypeHints = true,
--           includeInlayEnumMemberValueHints = true,
--         },
--       },
--       javascript = {
--         inlayHints = {
--           includeInlayParameterNameHints = "all",
--           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--           includeInlayFunctionParameterTypeHints = true,
--           includeInlayVariableTypeHints = true,
--           includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--           includeInlayPropertyDeclarationTypeHints = true,
--           includeInlayFunctionLikeReturnTypeHints = true,
--           includeInlayEnumMemberValueHints = true,
--         },
--       },
--     },
--   },
-- }

nvim_lsp.denols.setup {
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
  on_attach = on_attach,
}

local servers = {
  "pyright",
  "vimls",
  "cssls",
  "html",
  "sqlls",
  "intelephense",
  "dockerls",
  "bashls",
  "graphql",
  "svelte",
  "solc",
  "vuels",
  "marksman",
  "solargraph",
  -- "eslint",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = on_attach,
  }
end
nvim_lsp.vtsls.setup{
  on_attach = on_attach,
  settings = {
    vtsls = {
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        }
      }
    }
  }
}
nvim_lsp.tailwindcss.setup {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = on_attach,
}
nvim_lsp.cssmodules_ls.setup {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = on_attach,
}

nvim_lsp.yamlls.setup {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = on_attach,
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
}
nvim_lsp.rust_analyzer.setup {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = on_attach,
  cmd = { "rustup", "run", "stable", "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
    },
  },
  tools = {
    inlay_hints = {
      auto = false,
    },
  },
}

nvim_lsp.jsonls.setup {
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
  on_attach = on_attach,
}

nvim_lsp.prismals.setup {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = on_attach,
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern ".git"(fname)
      or require("lspconfig.util").root_pattern "package.json"(fname)
  end,
}

nvim_lsp.gopls.setup {
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
  on_attach = on_attach,
}

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.uv.fs_stat(path..'/.luarc.json') and not vim.uv.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          library = { vim.env.VIMRUNTIME }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

vim.diagnostic.config {
  signs = false,
  virtual_text = {
    prefix = "●",
    spacing = 8,
  },
  update_in_insert = true,
  float = {
    border = "rounded",
    source = true,
  },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.selene,
    -- null_ls.builtins.diagnostics.eslint_d,
    require"none-ls.diagnostics.eslint_d",
    null_ls.builtins.diagnostics.revive,
    null_ls.builtins.formatting.stylua,
    require"none-ls.formatting.eslint_d",
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.yapf,
    -- null_ls.builtins.formatting.rustfmt,
    require"none-ls.code_actions.eslint_d",
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.gitsigns,
  },
}

require('lspconfig').ast_grep.setup {}

local null_ls_stop = function()
  local null_ls_client
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.name == "null-ls" then
      null_ls_client = client
    end
  end
  if not null_ls_client then
    return
  end

  null_ls_client.stop()
end

vim.api.nvim_create_user_command("NullLsStop", null_ls_stop, {})

-- vim.lsp.config("ts_go_ls", {
--     cmd = { "tsgo", "--lsp", "-stdio" },
--     filetypes = {
--         "javascript",
--         "javascriptreact",
--         "javascript.jsx",
--         "typescript",
--         "typescriptreact",
--         "typescript.tsx",
--     },
--     root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
-- })
-- vim.lsp.enable("ts_go_ls")
