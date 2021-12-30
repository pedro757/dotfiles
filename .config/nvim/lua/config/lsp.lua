local nvim_lsp = require'lspconfig'
local configs = require'lspconfig.configs'
local update_capabilities = require'cmp_nvim_lsp'.update_capabilities
local null_ls = require"null-ls"

require"lspsaga".init_lsp_saga({
  code_action_keys = {
    quit = { "q", "<C-c>", "<esc>", "<C-x>"},
    exec = { '<CR>', "<C-l>" }
  },
  use_saga_diagnostic_sign = false,
  code_action_prompt = {
    enable = true,
    sign = false,
    sign_priority = 20,
    virtual_text = true,
  }
})

local on_attach = function(client, bufnr)
  local function option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=239 guibg=#504945
      hi LspReferenceText cterm=bold ctermbg=239 guibg=#504945
      hi LspReferenceWrite cterm=bold ctermbg=239 guibg=#504945
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local capabilities = update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { "pyright", "vimls", "cssls", "html", "sqlls", "intelephense", "dockerls", "bashls", "yamlls", "graphql", "gopls", "svelte", "tsserver" }
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
      cmd = {'ls_emmet', '--stdio'};
      filetypes = { 'html', 'css', 'scss', 'sass', 'javascript', 'javascriptreact', 'typescriptreact', 'markdown' };
      root_dir = function()
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

nvim_lsp.jsonls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
  on_attach = on_attach,
}

nvim_lsp.ls_emmet.setup{ capabilities = capabilities }

local sumneko_root_path = '/home/pedro/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup{
  root_dir = function(fname)
    return nvim_lsp.util.root_pattern('lua/', '.git')(fname) or nvim_lsp.util.path.dirname(fname)
  end,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        preloadFileSize = 135,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
}
vim.diagnostic.config({
  signs = false,
  virtual_text = {
    prefix = '●',
  },
  update_in_insert = true,
  float = {
    source = 'if_many',
  },
})

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.luacheck.with({
      extra_args = {"--globals", "vim"}
    }),
    -- null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.refactoring,
  },
})
