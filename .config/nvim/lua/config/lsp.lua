local nvim_lsp = require"lspconfig"
local configs = require"lspconfig.configs"
local update_capabilities = require"cmp_nvim_lsp".update_capabilities
local null_ls = require"null-ls"

require"lspsaga".init_lsp_saga {
  code_action_keys = {
    quit = { "q", "<C-c>", "<esc>", "<C-x>" },
    exec = { "<CR>", "<C-l>" },
  },
  use_saga_diagnostic_sign = false,
  code_action_prompt = {
    enable = true,
    sign = false,
    sign_priority = 20,
    virtual_text = true,
  },
}

local on_attach = function(client, bufnr)
  local function option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  option("omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Set autocommands conditional on server_capabilities
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

local capabilities = update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

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
  "gopls",
  "svelte",
  "solc",
  "cssmodules_ls",
  "vuels",
  "marksman",
  "tailwindcss",
}

-- nvim_lsp.emmet_ls.setup({
--   capabilities = capabilities,
--   filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
-- })

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = on_attach,
  }
end

if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      cmd = { "ls_emmet", "--inspect", "--stdio" },
      filetypes = {
        "html",
        "css",
        "scss",
        "sass",
        "javascript",
        "javascriptreact",
        "typescriptreact",
        "markdown",
        "handlebars",
        "hbs",
        "vue",
        "php"
      },
      root_dir = vim.loop.cwd,
      settings = {},
    },
  }
end

nvim_lsp.ls_emmet.setup { capabilities = capabilities }

nvim_lsp.tsserver.setup {
  init_options = require("nvim-lsp-ts-utils").init_options,
  capabilities = capabilities,
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")

    ts_utils.setup({
      enable_import_on_completion = true,
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      auto_inlay_hints = false,
    })

    ts_utils.setup_client(client)
  end,
}

nvim_lsp.jsonls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    json = {
      schemas = require"schemastore".json.schemas(),
      validate = { enable = true },
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
        keywordSnippet="Replace",
        callSnippet="Replace"
      },
      workspace = {
        preloadFileSize = 145,
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
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.yapf,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.refactoring,
  },
}
