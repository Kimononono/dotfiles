require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright",  'eslint', 'tsserver', 'tailwindcss', 'rust_analyzer' },
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>co', vim.lsp.buf.code_action, {})
  --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gd', require("telescope.builtin").lsp_definitions, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
  vim.keymap.set('n', '<Space>fi', require("telescope.builtin").lsp_incoming_calls, {})
  vim.keymap.set('n', '<Space>fo', require("telescope.builtin").lsp_outgoing_calls, {})
end


require("lspconfig").lua_ls.setup { 
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}

require("lspconfig").pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- NEODEV
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})


--require("lspconfig").eslint.setup{}

require("lspconfig").tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities
}


require("lspconfig").tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require("lspconfig").lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
      completion = {
        callSnippet = "Replace"
      }
    }
  }
}

require("lspconfig").rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities
}


vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		underline = not vt,
		signs = not vt,
	}
end, { desc = "toggle diagnostic" })
