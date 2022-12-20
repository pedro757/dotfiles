local nvim_lsp = require "lspconfig"
local null_ls = require "null-ls"

local on_attach = function(client, bufnr)
  local function option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  option("omnifunc", "v:lua.vim.lsp.omnifunc")
  if client.server_capabilities.colorProvider then
    require("document-color").buf_attach(bufnr, { mode = "background" })
  end
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        autocmd CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("typescript").setup {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern ".git/"(fname)
        or require("lspconfig.util").root_pattern "tsconfig.json"(fname)
        or require("lspconfig.util").root_pattern(
          "package.json",
          "jsconfig.json"
        )(fname)
    end,
  },
}

nvim_lsp.denols.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
  on_attach = on_attach,
}

-- nvim_lsp.tsserver.setup {
--   init_options = require("nvim-lsp-ts-utils").init_options,
--   capabilities = capabilities,
--   root_dir = function(fname)
--     return require("lspconfig.util").root_pattern ".git/"(fname)
--       or require("lspconfig.util").root_pattern "tsconfig.json"
--       or require("lspconfig.util").root_pattern(
--         "package.json",
--         "jsconfig.json",
--         ".git"
--       )(fname)
--   end,
--   on_attach = function(client, bufnr)
--     on_attach(client, bufnr)
--     local ts_utils = require "nvim-lsp-ts-utils"
--
--     ts_utils.setup {
--       enable_import_on_completion = true,
--       update_imports_on_move = true,
--       require_confirmation_on_move = true,
--       auto_inlay_hints = false,
--     }
--
--     ts_utils.setup_client(client)
--   end,
-- }

local servers = {
  "pyright",
  "vimls",
  "cssls",
  "html",
  "sqlls",
  "intelephense",
  "dockerls",
  "bashls",
  "yamlls",
  "graphql",
  "svelte",
  "solc",
  "cssmodules_ls",
  "vuels",
  "marksman",
  "tailwindcss",
  "solargraph",
  "rust_analyzer",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = on_attach,
  }
end

nvim_lsp.jsonls.setup {
  capabilities = capabilities,
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

nvim_lsp.gopls.setup {
  capabilities = capabilities,
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

local sumneko_root_path = "/home/pedro/Documents/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        enable = false,
        globals = { "vim" },
      },
      completion = {
        keywordSnippet = "Replace",
        callSnippet = "Replace",
      },
      workspace = {
        -- preloadFileSize = 145,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
}

vim.diagnostic.config {
  signs = false,
  virtual_text = {
    prefix = "●",
    spacing = 8,
  },
  update_in_insert = true,
  float = {
    source = "always",
  },
}

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.revive,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.yapf,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.refactoring,
  },
}

local null_ls_stop = function()
    local null_ls_client
    for _, client in ipairs(vim.lsp.get_active_clients()) do
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

return {
  on_attach = on_attach,
}
