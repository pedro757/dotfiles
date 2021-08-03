local nvim_lsp = require('lspconfig')
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}


local servers = { "pyright", "vimls", "jsonls", "cssls", "html", "sqlls", "intelephense", "dockerls", "bashls", "yamlls", "graphql", "gopls", "svelte", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = on_attach,
  }
end

local sumneko_root_path = '/home/pedro/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup{
  root_dir = nvim_lsp.util.root_pattern(".git", "init.vim") or nvim_lsp.util.bufdir,
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


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    -- virtual_text = false,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = false,
    underline = true,

    virtual_text = {
      spacing = 4,
      prefix = '●',
    },

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = true,
  }
)

vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    " ﬌  (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

vim.api.nvim_exec([[
augroup highlightsColorLsp
  autocmd!
  au ColorScheme * hi LspDiagnosticsDefaultHint guifg=#928374 ctermfg=245
  au ColorScheme * hi LspDiagnosticsDefaultInfo guifg=#928374 ctermfg=245
  au ColorScheme * hi LspDiagnosticsDefaultError guifg=#d65d0e ctermfg=red
  au ColorScheme * hi LspDiagnosticsDefaultWarning guifg=#fabd2f ctermfg=yellow
augroup END
]], false)
