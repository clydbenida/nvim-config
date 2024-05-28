local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()

local signature_setup = require("lsp_signature").setup {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  },
  floating_window = true,
  toggle_key = nil,
}

lsp_zero.preset("recommended")

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = { 'tsserver', 'eslint', 'cssls', 'cssmodules_ls', 'lua_ls' },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  })
})


lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'g.', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end, opts)

  require "lsp_signature".on_attach(signature_setup, bufnr) -- Note: add in lsp client on-attach
end)

lsp_zero.setup()
